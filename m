Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FC976DF54
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Aug 2023 06:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjHCEQq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Aug 2023 00:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjHCEQp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Aug 2023 00:16:45 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0FB4B2D68;
        Wed,  2 Aug 2023 21:16:43 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id CF89060863210;
        Thu,  3 Aug 2023 12:16:40 +0800 (CST)
Message-ID: <18edc2c7-2fb0-493b-9a9f-549acce4e87a@nfschina.com>
Date:   Thu, 3 Aug 2023 12:16:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fs: lockd: avoid possible wrong NULL parameter
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        nathan@kernel.org, trix@redhat.com, bfields@fieldses.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <CAKwvOdnRwmxGuEidZ=OWxSX60D6ry0Rb__DjSayga6um35Jsrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2023/8/3 05:40, Nick Desaulniers wrote:
> On Wed, Aug 2, 2023 at 3:25 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> I noticed that the function in question already has a guard:
> 322   if (hostname && memchr(hostname, '/', hostname_len) != NULL) {
>
> Which implies that hostname COULD be NULL.
>
> Should this perhaps simply be rewritten as:
>
> if (!hostname)
>    return NULL;
> if (memchr(...) != NULL)
>    ...
>
> Rather than bury yet another guard for the same check further down in
> the function? Check once and bail early.

Hi, Nick Desaulnier,

This may disrupt the logic of this function. So maybe the past one is better.

322         if (!hostname)
323                 return NULL;
                     ^^^^^^^^^^^^
If we return in this place.
                                                                                         
324         if (memchr(hostname, '/', hostname_len) != NULL) {
325                 if (printk_ratelimit()) {
326                         printk(KERN_WARNING "Invalid hostname \"%.*s\" "
327                                             "in NFS lock request\n",
328                                 (int)hostname_len, hostname);
329                 }
330                 return NULL;
331         }
332
333 retry:
334         spin_lock(&nsm_lock);
335
336         if (nsm_use_hostnames && hostname != NULL)
337                 cached = nsm_lookup_hostname(&ln->nsm_handles,
338                                         hostname, hostname_len);
339         else
340                 cached = nsm_lookup_addr(&ln->nsm_handles, sap);
                              ^^^^^^^^^^^^^^^
This case will be broken when hostname is NULL.

341
342         if (cached != NULL) {
343                 refcount_inc(&cached->sm_count);
344                 spin_unlock(&nsm_lock);
345                 kfree(new);
346                 dprintk("lockd: found nsm_handle for %s (%s), "
347                                 "cnt %d\n", cached->sm_name,
348                                 cached->sm_addrbuf,
349                                 refcount_read(&cached->sm_count));
350                 return cached;
351         }

>> I noticed a related bug which Smatch doesn't find, because of how Smatch
>> handles the dprintk macro.

Hi, Dan,

Great eye!
Should I send a separate patch for this bug and add you as Reported-by ?

>>
>> fs/lockd/host.c
>> truct nlm_host *nlmclnt_lookup_host(const struct sockaddr *sap,
>>     217                                       const size_t salen,
>>     218                                       const unsigned short protocol,
>>     219                                       const u32 version,
>>     220                                       const char *hostname,
>>     221                                       int noresvport,
>>     222                                       struct net *net,
>>     223                                       const struct cred *cred)
>>     224  {
>>     225          struct nlm_lookup_host_info ni = {
>>     226                  .server         = 0,
>>     227                  .sap            = sap,
>>     228                  .salen          = salen,
>>     229                  .protocol       = protocol,
>>     230                  .version        = version,
>>     231                  .hostname       = hostname,
>>     232                  .hostname_len   = strlen(hostname),
>>                                                   ^^^^^^^^
>> Dereferenced
>>
>>     233                  .noresvport     = noresvport,
>>     234                  .net            = net,
>>     235                  .cred           = cred,
>>     236          };
>>     237          struct hlist_head *chain;
>>     238          struct nlm_host *host;
>>     239          struct nsm_handle *nsm = NULL;
>>     240          struct lockd_net *ln = net_generic(net, lockd_net_id);
>>     241
>>     242          dprintk("lockd: %s(host='%s', vers=%u, proto=%s)\n", __func__,
>>     243                          (hostname ? hostname : "<none>"), version,
>>                                   ^^^^^^^^
>> Checked too late.
>>
>>     244                          (protocol == IPPROTO_UDP ? "udp" : "tcp"));
>>     245
>>
>> regards,
>> dan carpenter
>
>

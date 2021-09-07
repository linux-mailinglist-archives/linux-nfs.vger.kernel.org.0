Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4692B40277E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Sep 2021 13:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbhIGLBP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Sep 2021 07:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233669AbhIGLBP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 7 Sep 2021 07:01:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9540C60F6D;
        Tue,  7 Sep 2021 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631012409;
        bh=KR5neMehlbXKGK2XjjBGPoTIhok2GaxJj8w7xUVYMM0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i+fl357rAMtXTPw6EujZEk6wCADK+srAqusgmp+yTIurFOAnUtbJXXMu8QdgVK9Zj
         8bwgk7MwzD11pO4pZsFAeX8BUtqr7NzY6XQo4XPmceFFYSQA1BthF6NpzhMhlpH0jk
         8R0prz0lacqgHc5yvDhKTnTXTTIIQpK9q2X640cKlLJQScNT0OYahzmibsfpdQ2H7G
         PrLuI24NdHwBEVIJzoet0dxUiZ6QsKNc+b56eskT8GzXxzhs0/Rh/ntBdmgIEh0AWn
         mh0bGcTpsRIUmUKbVoWTHOTmNSgiiNKzEn4d4Op1pBZpV6xtX2p0cmVn9wLx2CFmXT
         H7qnj1B6IApFg==
Message-ID: <deba812574c9b898f99fc08f0c3fa23e85fc36ca.camel@kernel.org>
Subject: Re: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Bruce Fields <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Tue, 07 Sep 2021 07:00:07 -0400
In-Reply-To: <20210907080732.GA20341@kili>
References: <20210907080732.GA20341@kili>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2021-09-07 at 11:07 +0300, Dan Carpenter wrote:
> Hello Jeff Layton,
> 
> The patch d20c11d86d8f: "nfsd: Protect session creation and client
> confirm using client_lock" from Jul 30, 2014, leads to the following
> Smatch static checker warning:
> 
> 	net/sunrpc/addr.c:178 rpc_parse_scope_id()
> 	warn: sleeping in atomic context
> 
> net/sunrpc/addr.c
>     161 static int rpc_parse_scope_id(struct net *net, const char *buf,
>     162                               const size_t buflen, const char *delim,
>     163                               struct sockaddr_in6 *sin6)
>     164 {
>     165         char *p;
>     166         size_t len;
>     167 
>     168         if ((buf + buflen) == delim)
>     169                 return 1;
>     170 
>     171         if (*delim != IPV6_SCOPE_DELIMITER)
>     172                 return 0;
>     173 
>     174         if (!(ipv6_addr_type(&sin6->sin6_addr) & IPV6_ADDR_LINKLOCAL))
>     175                 return 0;
>     176 
>     177         len = (buf + buflen) - delim - 1;
> --> 178         p = kmemdup_nul(delim + 1, len, GFP_KERNEL);
>     179         if (p) {
>     180                 u32 scope_id = 0;
>     181                 struct net_device *dev;
>     182 
>     183                 dev = dev_get_by_name(net, p);
>     184                 if (dev != NULL) {
>     185                         scope_id = dev->ifindex;
>     186                         dev_put(dev);
>     187                 } else {
>     188                         if (kstrtou32(p, 10, &scope_id) != 0) {
>     189                                 kfree(p);
>     190                                 return 0;
>     191                         }
>     192                 }
>     193 
>     194                 kfree(p);
>     195 
>     196                 sin6->sin6_scope_id = scope_id;
>     197                 return 1;
>     198         }
>     199 
>     200         return 0;
>     201 }
> 
> The call tree is:
> 
> nfsd4_setclientid() <- disables preempt
> -> gen_callback()
>    -> rpc_uaddr2sockaddr()
>       -> rpc_pton()
>          -> rpc_pton6()
>             -> rpc_parse_scope_id()
> 
> The commit added a spin_lock to nfsd4_setclientid().
> 
> fs/nfsd/nfs4state.c
>   4023                          trace_nfsd_clid_verf_mismatch(conf, rqstp,
>   4024                                                        &clverifier);
>   4025          } else
>   4026                  trace_nfsd_clid_fresh(new);
>   4027          new->cl_minorversion = 0;
>   4028          gen_callback(new, setclid, rqstp);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>   4029          add_to_unconfirmed(new);
>   4030          setclid->se_clientid.cl_boot = new->cl_clientid.cl_boot;
>   4031          setclid->se_clientid.cl_id = new->cl_clientid.cl_id;
>   4032          memcpy(setclid->se_confirm.data, new->cl_confirm.data, sizeof(setclid->se_confirm.data));
>   4033          new = NULL;
>   4034          status = nfs_ok;
>   4035  out:
>   4036          spin_unlock(&nn->client_lock);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is the new lock.
> 
>   4037          if (new)
>   4038                  free_client(new);
>   4039          if (unconf) {
>   4040                  trace_nfsd_clid_expire_unconf(&unconf->cl_clientid);
>   4041                  expire_client(unconf);
>   4042          }
>   4043          return status;
> 
> regards,
> dan carpenter

(cc'ing Bruce and Chuck)

Wow that is an oldie, but it does seem to be a legit bug.

Probably we should just make rpc_parse_scope_id use an on-stack buffer
instead of calling kmemdup_nul there. Thoughts?
-- 
Jeff Layton <jlayton@kernel.org>


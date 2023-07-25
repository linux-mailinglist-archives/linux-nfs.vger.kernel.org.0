Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFED8761DD9
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 17:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjGYP72 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGYP70 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 11:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33210E5
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jul 2023 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690300722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UebXzSZJJbns4Q4iwMQ1Tl1eusSXjfQY70IBKGqiPDI=;
        b=KNYaWpxATuy0nIRQPR/NdM42d5qHMosGMAYN7D3GmRHUTaFtQ5nsBvVGlX8Y1My3b4LcXi
        6YMF6RZT/sRgmlJq8s2E3RXl8WlIJzAcEv/pJwEUUI8UvLvx0HRm+QjXn0ilp6504NHc6y
        JG6gALl9nlqViPUAMlc3DFbRUk9J3H0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-MZgeXcd0PZ2KTa_ZRhD4mg-1; Tue, 25 Jul 2023 11:58:41 -0400
X-MC-Unique: MZgeXcd0PZ2KTa_ZRhD4mg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7672918d8a4so149743685a.0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jul 2023 08:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690300720; x=1690905520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UebXzSZJJbns4Q4iwMQ1Tl1eusSXjfQY70IBKGqiPDI=;
        b=jcTzF1jEyOHqDP3QGbo6ICwQuppLegnLpYGwgh3BG9JaL3Jv7CCLM7vfgjC5rw7DrU
         KcKKsHuy6+XTRleSgwM0p3IBSnJ8WPoKFj2p20EvfSVIdSqqOQWP5xm39Ik4kOsjx10l
         VuSoKvK69V78N5n7J5iR1PK/EEJBzS/6ZLyhDkluAitw+mrK8bnoLIngR9Cw2lDIPgdx
         9F7GTNPOkYOZ8GOEHkkzxCA/N1ZhcGlvhtEEa104qq2Kl4sYzvHQice5m+y7i9+MxOGs
         KflIcDMmCZLCUmjrNfk587r/mQ6zl8qoHa7UdeEamvVVUxBsKrPt1vavTzC1LVdNqImZ
         Vh5g==
X-Gm-Message-State: ABy/qLbPzxvB9Fv37Q94F1HG1ZrTMPOeRyDiMfPdFGCk5+tHenmctyeg
        wH2bu9257axvGhX4Cfd3r3C4SROtO6oxP1M2z34byYuXvL9EbDLvyAMaNEBc0VjAZYbTtgJoUBD
        u0p2ItoshBb3fAAv+kd1bpADY163G
X-Received: by 2002:a05:620a:2409:b0:76a:f689:dff2 with SMTP id d9-20020a05620a240900b0076af689dff2mr8656912qkn.7.1690300719990;
        Tue, 25 Jul 2023 08:58:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHU88rw5EM8xm4Da/LxK2KaVzYwcS1Da7lcAcB5Gmy4x58OCpFNTGYa5OgCMHBQvSSMnRKWUw==
X-Received: by 2002:a05:620a:2409:b0:76a:f689:dff2 with SMTP id d9-20020a05620a240900b0076af689dff2mr8656899qkn.7.1690300719711;
        Tue, 25 Jul 2023 08:58:39 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id pe39-20020a05620a852700b00767cbd5e942sm3752235qkn.72.2023.07.25.08.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 08:58:39 -0700 (PDT)
Message-ID: <42fe1621-d9c3-2fd5-807c-539ddd917ac8@redhat.com>
Date:   Tue, 25 Jul 2023 11:58:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] systemd: Ensure that statdpath exists using
 systemd-tmpfiles
To:     Alberto Garcia <berto@igalia.com>
Cc:     linux-nfs@vger.kernel.org
References: <20230713102531.131072-1-berto@igalia.com>
 <5230337e-b028-0e86-9693-c29f7d1165b2@redhat.com>
 <ZLcPIEUeVKElhqwB@igalia.com>
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <ZLcPIEUeVKElhqwB@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sorry for the delay... I'll take another look

steved.

On 7/18/23 6:16 PM, Alberto Garcia wrote:
> On Sat, Jul 15, 2023 at 04:53:02PM -0400, Steve Dickson wrote:
>>> This is not the case of rpc-statd: if sm and sm.bak (under
>>> $statdpath, which also defaults to /var/lib/nfs) are missing the
>>> daemon will refuse to start and will exit with an error.
>> Why are they would be missing? They are created on the nfs-utils
>> installation.
> 
> Hello,
> 
> yes, in a traditional Linux system that is indeed the case. The idea
> behind this is to add support to factory reset and stateless scenarios
> like the ones described here:
> 
>     https://0pointer.net/blog/projects/stateless.html
> 
> The goal is that a system can boot with an empty /var and
> all necessary files and directories are created without user
> intervention. In the case of nfs-utils this is already happening
> except for rpc-statd.
> 
> For projects that use systemd this is generally easy to do without
> touching the code because systemd provides directives that can be used
> to ensure that /var/lib/foo, /var/log/foo, etc. exist before a service
> is started.
> 
> In the rpc-statd case this would normally be as simple as adding
> something like "StateDirectory=nfs/sm nfs/sm.bak" to the .service
> file. However it seems that this one is a bit special because it goes
> like this if I'm not mistaken:
> 
> 1. The configure script determines $statduser (the value of
>     --with-statduser, else rpcuser if available, else nobody).
> 
> 2. 'make install' creates sm / sm.bak followed by chown $statduser
> 
> 3. rpc.statd starts as root, then does lstat("/var/lib/nfs/sm", &st)
>     and finally setgid(st.st_gid) / setuid(st.st_uid). At this point
>     uid/gid is not necessarily what was set during configure/make
>     install ($statduser/root) because downstreams can create a
>     different user/group and change the ownership of those directories.
> 
> StateDirectory and similar directives from systemd can only create
> directories owned by the user that starts the service, but since here
> the service needs to run as root this would not work.
> 
> systemd-tmpfiles can be used for cases like this one, and that's why I
> chose it for this patch.
> 
>> Just curious... how did you test this patch? When I apply it
>> I get this error
>>
>> Failed to insert: creating /var/lib/nfs/statd/sm/<client>: Permission denied
>> STAT_FAIL to <server> for SM_MON of <server_ip>
>>
>> Maybe this is packing issue but I'm thinking it is more
>> of systemd issue... the permissions on the sm directory
>> are
>> 283 drwx------. 2 nobody rpcuser 6 Apr 18 20:00 /var/lib/nfs/statd/sm
>> instead of
>> 283 drwx------. 2 rpcuser rpcuser 6 Apr 18 20:00 /var/lib/nfs/statd/sm
> 
> Are you creating a package with the patched sources? If it's something
> like the Fedora one then I think that the problem is that since the
> configure script does not use --with-statduser then there's a mismatch
> between the user that appears in nfs-utils.conf (added by this patch)
> and these lines from the .spec file:
> 
> %dir %attr(700,rpcuser,rpcuser) %{_sharedstatedir}/nfs/statd
> %dir %attr(700,rpcuser,rpcuser) %{_sharedstatedir}/nfs/statd/sm
> %dir %attr(700,rpcuser,rpcuser) %{_sharedstatedir}/nfs/statd/sm.bak
> 
> So probably /var/lib/nfs/statd/sm is drwx------ nobody but
>              /var/lib/nfs/statd    is drwx------ rpcuser ?
> 
> Passing --with-statduser=rpcuser to configure should fix this problem.
> 
> After having a look at a couple of downstream packages it seems that
> they simply don't use --with-statduser at all and change the ownership
> to whatever user/group they want in their post-installation scripts.
> So they would need to start doing it if this patch is included in
> nfs-utils.
> 
> I realize that although this should be trivial to handle by downstream
> packagers it does require manual intervention so I'm not expecting it
> to be completely uncontroversial. But if you like the overall idea I'm
> happy to discuss / iterate this patch further. This can of course be
> applied only by the downstreams who are interested in this feature,
> but since nfs-utils already uses systemd and the change is rather
> small I thought it made more sense to have it directly upstream.
> 
> Regards,
> 
> Berto
> 


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A074632D79
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Nov 2022 20:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiKUT4L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Nov 2022 14:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiKUT4K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Nov 2022 14:56:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E83175A5
        for <linux-nfs@vger.kernel.org>; Mon, 21 Nov 2022 11:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669060481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSYqk8hQ39LOorA789inV4GLsobZ0K+oNgrq8WrZeVE=;
        b=L6cTSOUSfrgvYYgdSsVmwfEB9GAG5tqeb7nBrBJqqiRvZqjPYXy0zlNCXNsG3WNAOyQt/n
        ysSGe5kOBB5BoIewjLdqmr+uKCpEZ4LsKA5UWsCpqpC4FGl+MyfalcP89IhLWpqKGdQ5rf
        vgufFjiyrJtbybdWMFC0CyIP8eeo5kw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-195-AzF6auy3Nyy7oQ3B63izdA-1; Mon, 21 Nov 2022 14:54:39 -0500
X-MC-Unique: AzF6auy3Nyy7oQ3B63izdA-1
Received: by mail-qt1-f198.google.com with SMTP id cm12-20020a05622a250c00b003a521f66e8eso12807125qtb.17
        for <linux-nfs@vger.kernel.org>; Mon, 21 Nov 2022 11:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSYqk8hQ39LOorA789inV4GLsobZ0K+oNgrq8WrZeVE=;
        b=cymk0NwHUw8BoaUTqrLXtCR+Wdhdhtab9BTQL3ukxgka2qWuXoaSsdLB+jKy9XAfdh
         YDY1kEhsFMApBr8N9OoKOxCPbQXrDnlHGh8dkC2BvegUsg1W4j31DWmpdYeb3NR22Rzt
         8x5WW9j1Ex8Qlb6LjZ4mFbUOUTaVKG2bnbfCKKh0OaFeQB2mQRCNkyuIY+fihdDQAAPU
         Azz94qyi2aJjmLY0MU5yKqyaPg22DRPcPUPulvwvbjFDcMFL65IKZFVoAJ+RVTcMw70a
         jek8ANyVar9YpWlmxJ+Gxz3wh5VIVjdQl1dJ/zW59U1FxK0aBVLbf5AV4kn7ykaYf4lM
         RS4Q==
X-Gm-Message-State: ANoB5pmMqW9v5S0X3iavdn3LZPP85sx/fI7/l/NMj+1Ndzovs8ax4DE7
        iqNcnldLT7mElJd6gxpW1JE+KSx85GvLGtGAFt/jgnc3rylljj9ahe3uquml9CP9YLV+fFF+pk+
        cvHXrPetOPTy8k8u2etZ1
X-Received: by 2002:a05:620a:10a3:b0:6fa:156e:44c0 with SMTP id h3-20020a05620a10a300b006fa156e44c0mr3708686qkk.293.1669060478629;
        Mon, 21 Nov 2022 11:54:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4yXkiHIWDfhvh2GDwt0l8FbqpkMnW+i58Lv4Rq0bLytSvAb1LJKa2nwSJUpGg7G/ABp6g6Cw==
X-Received: by 2002:a05:620a:10a3:b0:6fa:156e:44c0 with SMTP id h3-20020a05620a10a300b006fa156e44c0mr3708675qkk.293.1669060478329;
        Mon, 21 Nov 2022 11:54:38 -0800 (PST)
Received: from [172.31.1.6] ([70.105.255.216])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b006f9f3c0c63csm9152485qkp.32.2022.11.21.11.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 11:54:37 -0800 (PST)
Message-ID: <16370de9-613f-e4b6-59a8-23f4b8b4e659@redhat.com>
Date:   Mon, 21 Nov 2022 14:54:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH nfs-utils - v2] nfsd: allow server scope to be set with
 config or command line.
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <166813011417.19313.12216066495338584736@noble.neil.brown.name>
 <166848711530.4614.10805714091203567578@noble.neil.brown.name>
 <166848720192.4614.15106591314080263893@noble.neil.brown.name>
 <78d9e894-7c30-fa5a-58ee-b99b161e475e@redhat.com>
 <166898786780.4614.13142742731262266686@noble.neil.brown.name>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <166898786780.4614.13142742731262266686@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/20/22 6:44 PM, NeilBrown wrote:
> On Sun, 20 Nov 2022, Steve Dickson wrote:
>> Hey!
>>
>> On 11/14/22 11:40 PM, NeilBrown wrote:
>>>
>>> NFSv4.1 and later require the server to report a "scope".  Servers with
>>> the same scope are expected to understand each other's state ids etc,
>>> though may not accept them - this ensure there can be no
>>> misunderstanding.  This is helpful for migration.
>>>
>>> Servers with different scope are known to be different and if a server
>>> appears to change scope on a restart, lock recovery must not be
>>> attempted.
>>>
>>> It is important for fail-over configurations to have the same scope for
>>> all server instances.  Linux NFSD sets scope to host name.  It is common
>>> for fail-over configurations to use different host names on different
>>> server nodes.  So the default is not good for these configurations and
>>> must be over-ridden.
>>>
>>> As discussed in
>>>     https://github.com/ClusterLabs/resource-agents/issues/1644
>>> some HA management tools attempt to address this with calls to "unshare"
>>> and "hostname" before running "rpc.nfsd".  This is unnecessarily
>>> cumbersome.
>>>
>>> This patch adds a "-S" command-line option and nfsd.scope config value
>>> so that the scope can be set easily for nfsd.
>>>
>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>>    systemd/nfs.conf.man |  1 +
>>>    utils/nfsd/nfsd.c    | 17 ++++++++++++++++-
>>>    utils/nfsd/nfsd.man  | 13 ++++++++++++-
>>>    3 files changed, 29 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
>>> index b95c05a68759..bfd3380ff081 100644
>>> --- a/systemd/nfs.conf.man
>>> +++ b/systemd/nfs.conf.man
>>> @@ -172,6 +172,7 @@ for details.
>>>    Recognized values:
>>>    .BR threads ,
>>>    .BR host ,
>>> +.BR scope ,
>>>    .BR port ,
>>>    .BR grace-time ,
>>>    .BR lease-time ,
>>> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
>>> index 4016a761293b..249df00b448d 100644
>>> --- a/utils/nfsd/nfsd.c
>>> +++ b/utils/nfsd/nfsd.c
>>> @@ -23,6 +23,7 @@
>>>    #include <sys/socket.h>
>>>    #include <netinet/in.h>
>>>    #include <arpa/inet.h>
>>> +#include <sched.h>
>>>    
>>>    #include "conffile.h"
>>>    #include "nfslib.h"
>>> @@ -39,6 +40,7 @@ static void	usage(const char *);
>>>    static struct option longopts[] =
>>>    {
>>>    	{ "host", 1, 0, 'H' },
>>> +	{ "scope", 1, 0, 'S'},
>>>    	{ "help", 0, 0, 'h' },
>>>    	{ "no-nfs-version", 1, 0, 'N' },
>>>    	{ "nfs-version", 1, 0, 'V' },
>>> @@ -69,6 +71,7 @@ main(int argc, char **argv)
>>>    	int	count = NFSD_NPROC, c, i, error = 0, portnum, fd, found_one;
>>>    	char *p, *progname, *port, *rdma_port = NULL;
>>>    	char **haddr = NULL;
>>> +	char *scope = NULL;
>>>    	int hcounter = 0;
>>>    	struct conf_list *hosts;
>>>    	int	socket_up = 0;
>>> @@ -168,8 +171,9 @@ main(int argc, char **argv)
>>>    			hcounter++;
>>>    		}
>>>    	}
>>> +	scope = conf_get_str("nfsd", "scope");
>>>    
>>> -	while ((c = getopt_long(argc, argv, "dH:hN:V:p:P:stTuUrG:L:", longopts, NULL)) != EOF) {
>>> +	while ((c = getopt_long(argc, argv, "dH:S:hN:V:p:P:stTuUrG:L:", longopts, NULL)) != EOF) {
>>>    		switch(c) {
>>>    		case 'd':
>>>    			xlog_config(D_ALL, 1);
>>> @@ -190,6 +194,9 @@ main(int argc, char **argv)
>>>    			haddr[hcounter] = optarg;
>>>    			hcounter++;
>>>    			break;
>>> +		case 'S':
>>> +			scope = optarg;
>>> +			break;
>>>    		case 'P':	/* XXX for nfs-server compatibility */
>>>    		case 'p':
>>>    			/* only the last -p option has any effect */
>>> @@ -367,6 +374,14 @@ main(int argc, char **argv)
>>>    	if (lease  > 0)
>>>    		nfssvc_set_time("lease", lease);
>>>    
>>> +	if (scope) {
>>> +		if (unshare(soc) < 0 ||
> 
> Where did that "soc" come from?  In the email I sent this line is
> +		if (unshare(CLONE_NEWUTS) < 0 ||
I have no idea... it must be my evil twin again!! :-)

> 
>>> +		    sethostname(scope, strlen(scope)) < 0) {
>>> +			xlog(L_ERROR, "Unable to set server scope: %m");
>>> +			error = -1;
>>> +			goto out;
>>> +		}
>>> +	}
>> So setting the scope resets the utsname and hostname which
>> will effect the entire system, possibly negatively. Breaking
>> DNS... who knows what is going to happen, when the hostname
>> is changed on the fly.. But with that said..
> 
> No, it doesn't affect the entire system.  The unshare() call creates a
> new UTS namespace that is private to this process.  The sethostname call
> then sets the host name in that uts namespace - still private to this
> process.
> 
> Then when rpc.nfsd asks the kernel to start some nfsd threads the
> nfsd_svc() function in the kernel (since linux-5.7) does:
> 
> 	strscpy(nn->nfsd_name, utsname()->nodename,
> 		sizeof(nn->nfsd_name));
> 
> which takes a copy of that new hostname for internal usage.
> Then the rpc.nfsd exits and the temporary UTS namespace is destroyed.
> 
> So this is all really just a somewhat unusual way to pass a config
> parameter to the kernel.  It is an internal implementation detail,
> nothing more.
Got it... thanks for the explanation.

> 
> 
>>
>> I understand what you are trying to doing, but I just
>> don't think it's documented well enough... Saying something
>> like setting the scope *will* change both utsname and hostname
> 
> Just FYI: "utsname" is everything reported by 'uname -a' which includes
> the hostname.
Yup!

steved.
> 
>> to given scope or something like... I just want be more explicit
>> as to what setting the scope is actually going to do.
>>
>> steved.
> 
> Thanks,
> NeilBrown
> 
> 
>>
>>>    	i = 0;
>>>    	do {
>>>    		error = nfssvc_set_sockets(protobits, haddr[i], port);
>>> diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
>>> index bb99fe2b1d89..dc05f3623465 100644
>>> --- a/utils/nfsd/nfsd.man
>>> +++ b/utils/nfsd/nfsd.man
>>> @@ -35,9 +35,17 @@ Note that
>>>    .B lockd
>>>    (which performs file locking services for NFS) may still accept
>>>    request on all known network addresses.  This may change in future
>>> -releases of the Linux Kernel. This option can be used multiple time
>>> +releases of the Linux Kernel. This option can be used multiple times
>>>    to listen to more than one interface.
>>>    .TP
>>> +.B \S " or " \-\-scope scope
>>> +NFSv4.1 and later require the server to report a "scope" which is used
>>> +by the clients to detect if two connections are to the same server.
>>> +By default Linux NFSD uses the host name as the scope.
>>> +.sp
>>> +It is particularly important for high-availablity configurations to ensure
>>> +that all potential server nodes report the same server scope.
>>> +.TP
>>>    .B \-p " or " \-\-port  port
>>>    specify a different port to listen on for NFS requests. By default,
>>>    .B rpc.nfsd
>>> @@ -134,6 +142,9 @@ will listen on.  Use of the
>>>    .B --host
>>>    option replaces all host names listed here.
>>>    .TP
>>> +.B scope
>>> +Set the server scope.
>>> +.TP
>>>    .B grace-time
>>>    The grace time, for both NFSv4 and NLM, in seconds.
>>>    .TP
>>
>>
> 


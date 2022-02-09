Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6064AF7F4
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 18:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbiBIRUs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 12:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbiBIRUr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 12:20:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09659C0613C9
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 09:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644427250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E2sQk+BSHMdIadozFsPY/pS58Mm8cpvmOPkpVuhseZI=;
        b=SzFLcdCrhfldhYT2QPBqQ966tNuGkacfIR/FK3GkVaV5Pc863/yo5NmRQ7VF6ltFH/uGJE
        Oz1TFD5k/iAZQEAuSiNZjogyE3QIeW1Pt/o3pXCUlri5cSCS/ogwB8h4jaNiPxqI5k2gS3
        XA5SZAjmxCeaHDp213tK5cyyF2zOz70=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-gmdXO4NwMkSDsjqN5nIhxg-1; Wed, 09 Feb 2022 12:20:49 -0500
X-MC-Unique: gmdXO4NwMkSDsjqN5nIhxg-1
Received: by mail-lf1-f71.google.com with SMTP id w42-20020a0565120b2a00b00432f6a227e0so724829lfu.3
        for <linux-nfs@vger.kernel.org>; Wed, 09 Feb 2022 09:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=E2sQk+BSHMdIadozFsPY/pS58Mm8cpvmOPkpVuhseZI=;
        b=rPSZoM0d3cHfgFJny9aZ9mTqf36owIYI4t32is/3tyLVS01EGZnUnEnBg7GttAXWfL
         zTCcBZx8UpwAa43FeMeKmuCHtF1rk6EqJtEQjibXS4AXwCPkg2+008WrvjD4Z7N/VuCC
         /OoWd17PXcRa0m3ZtKdZPESD1PNy6EMYR0lJEqvChSUdgf47HTJXcTN/UZPTIDp2vNvI
         YAlLTehnM89HEfX/rwjmcRoVHqqiOz6wqsOXrkiNJXA8qf3uL7w+nE8G6Vmk09zXBpj1
         ZEZ8IxsSrwjz/q7dlDixkYvarqHcI2ryKl0h9KzTzldB6dFou5pot5c35Q6Q44O+aLr9
         z7fQ==
X-Gm-Message-State: AOAM533AU3SBUtVbqGl06iTVvp5tGaKY+LVhdMZSwGf1ZAVF8s9NFI3t
        1lUJ4UJd/xKrOkioRiXtNXYyGzXYaTieg6/MB1ZUCPPtvyqe0zub+BnPrAhTI3a/WNXqK43iQgx
        3/ZfQBzTKYRB0iW6asQu+GMGehYnB1sQnkm+n
X-Received: by 2002:a05:6512:31ca:: with SMTP id j10mr2272681lfe.363.1644427247128;
        Wed, 09 Feb 2022 09:20:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycGK8LYZ1H8yWBx2dTGUQZjizEruwa1lF6oxMhNWSAhkSAyy8YddWNIZqrseV4ySdgVKNrzjRH2gBgyODomUg=
X-Received: by 2002:a05:6512:31ca:: with SMTP id j10mr2272661lfe.363.1644427246767;
 Wed, 09 Feb 2022 09:20:46 -0800 (PST)
MIME-Version: 1.0
References: <CA+-cMpFmMr8FQKODmR5JAB8rZhzptZ_KPX5DasLM_sbvbko+GA@mail.gmail.com>
 <CA+-cMpHHeK1zSMTQiYtd5GuL2UVp8n-BY228aeUUrQq5KCOc2A@mail.gmail.com>
 <CAFX2Jfk4QquitkteegAXBfF0HMM0cGiCgLJPfdhESPBuDswrbw@mail.gmail.com>
 <CA+-cMpG8pbARdWSHyQG0mcg8ZJi6UntZSJk8555+OE5Ra5C2aw@mail.gmail.com> <CA+-cMpGC5r7poAjQ65Tm97cEcyjMoZUzYCdfBnD-CziS-yKsOA@mail.gmail.com>
In-Reply-To: <CA+-cMpGC5r7poAjQ65Tm97cEcyjMoZUzYCdfBnD-CziS-yKsOA@mail.gmail.com>
From:   Rahul Rathore <rrathore@redhat.com>
Date:   Wed, 9 Feb 2022 22:50:35 +0530
Message-ID: <CA+-cMpH3D2YjE8cc_JPHdeW451WZaSN9seZUR4L-9Jre1VgToA@mail.gmail.com>
Subject: Re: Testing Results - Add a tool for using the new sysfs files - rpcctl
To:     Anna Schumaker <schumaker.anna@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Anna,

I am yet to do more tests.

However, I will share what I have done till now.

I have upgraded to 5.16.5-200.fc35.x86_64 and some of the problems have
disappeared.

However, some still exist.

1- I am still unable to run xprt commands.

[root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
--id 3 --offline
[Errno 22] Invalid argument
[root@rrathore-upstream-sysfs nfs-utils]#
[root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
--id 3 192.168.122.29 --offline
usage: rpcctl.py [-h] {client,switch,xprt} ...
rpcctl.py: error: unrecognized arguments: 192.168.122.29
[root@rrathore-upstream-sysfs nfs-utils]#
[root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
--id 3 --dstaddr 192.168.122.29 --offline
[Errno 22] Invalid argument
[root@rrathore-upstream-sysfs nfs-utils]#
[root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
--id 3 192.168.122.127 --offline
usage: rpcctl.py [-h] {client,switch,xprt} ...
rpcctl.py: error: unrecognized arguments: 192.168.122.127
[root@rrathore-upstream-sysfs nfs-utils]#
[root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
--id 1 --dstaddr 192.168.122.29 --offline
[Errno 95] Operation not supported
[root@rrathore-upstream-sysfs nfs-utils]#

If I am doing something wrong, kindly provide some examples.

2- However, the switch command worked.

[root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py switch
set --id 2 --dstaddr 192.168.122.30
switch 2: xprts 1, active 1, queue 1
xprt 3: tcp, 192.168.122.30
[root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py switch
switch 0: xprts 1, active 1, queue 0
xprt 0: local, /var/run/rpcbind.sock [main]
switch 1: xprts 1, active 1, queue 0
xprt 1: local, /var/run/gssproxy.sock [main]
switch 2: xprts 1, active 1, queue 1
xprt 3: tcp, 192.168.122.30

Now I see:-
[root@rrathore-upstream-sysfs nfs-utils]# ss | grep -i nfs
tcp   SYN-SENT 0      1                        192.168.122.125:883
192.168.122.30:nfs

This is picking correct info:-

cat /sys/kernel/debug/sunrpc/rpc_clnt/*/xprt/info
addr:  192.168.122.30
port:  2049
state: 0x15
netid: tcp
addr:  192.168.122.30
port:  2049
state: 0x15


I am not sure of the motive of this command. Is the motive to set IP of NFS
Server to set/change from Client.

Though the current O/P and all is correct. But in this manner NFS will
suffer. cd / ls or any other operation over nfs will hang like below:-

[root@rrathore-upstream-sysfs nfs-utils]# df -h

^C

If the motive was to set NFS Server IP, then it fails to do so as my NFS
Server IP is still an old one and not 192.168.122.30.


Just a suggestion, if you can post some examples in your man page it will
be great.


I am still performing some tests. Will keep you posted.

Regards,
Rahul


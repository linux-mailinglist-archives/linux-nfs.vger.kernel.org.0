Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2219E21213B
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2020 12:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgGBK2d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jul 2020 06:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgGBK2c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jul 2020 06:28:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F7DC08C5C1
        for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2020 03:28:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so27610430ljp.6
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jul 2020 03:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NDf/Go6IME0UpwwW8wupU7VZWzCSs3tnOTVhxAuwUsY=;
        b=A0XEcDFrYGLt2KtCFb1s+rcOCxyxg8P60DwfB/zkyGaV2Sx2c2QCyjQSNJTGbyxaOP
         AFQPMJ2tIwxq87Eu6pksM6NujuJrp0lxZWwINXSEnD9JY6bamil054MmScjTD9o4hiKd
         xjKlm7M0oWpfemS5DZ9tlUdPaod+bZuugCuoWO7VOu8V2tVa4uRD9znWGaSRPep4/SY1
         bUNrVXrTYn90v+PPKrtgF+U1WXf4SiuSAM7Q10vEZy3EEg7fXd/58ANh8Gx9juSc2ZXA
         tFCbsB00btir4FhuydJcZXbNwOkH76fjf3LgB7KrSgWzSTP0xAWU+XDI0P2UyG41ViPa
         cF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NDf/Go6IME0UpwwW8wupU7VZWzCSs3tnOTVhxAuwUsY=;
        b=c0gHrdvHG+j8a0Z0VSrlPeqQdIP+Arflb1U+7QiewAKufNxJBxuj7j67yycYZ1NIin
         gpLfuws4BhWrVfANPpKE+xZe+7t1l5PCt0mGbRDuVLmPYLgsw2ziUmFxD5J07dDNQqOT
         9R5DQM8ckdE+zzcvyXX1bMwFcFxuXUg0AGxXhMrAD4iGQb64zLx+5Iipt/Kdzl9JXauh
         cH7cTtaD63pZNjDQKD6XxKHJQU1XkIvHMRBKkQijemCqFJrVMejRRo8ScMHquO7APGfI
         gOpPO/3dLCdaCm5oF9/4/ZN3ARMpNAO8f+8yXLArUbux7G/y65OXSCvGGk0zT3RflDqZ
         VA8A==
X-Gm-Message-State: AOAM531icslPxyXVtEPuQawOe4En1M/BL01qM4e/EBZK7wvpaUQPK5WR
        82zQqv4nThFOYnsDZxGYh9e8S9THO08kjlrLAMfVtvgy
X-Google-Smtp-Source: ABdhPJyieQgZm3lyw6dLpKoOI3T8TcLwRJlOtrzNmvaoZk+WtotZ9VUvus4DY00wVdXv5VG8w8Ag6wAbsv+PCqAvk5U=
X-Received: by 2002:a2e:890d:: with SMTP id d13mr16333311lji.75.1593685709691;
 Thu, 02 Jul 2020 03:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <0aee01d63d91$1f104300$5d30c900$@gmail.com> <7E441550-FCCF-492E-BACB-271A42D4A6C4@oracle.com>
 <119601d63f43$9d55e860$d801b920$@gmail.com> <CAK3fRr-cV_0c-sHhA2rMswrHEcLrkNfHs-=ejHRS8-j8zzObhA@mail.gmail.com>
In-Reply-To: <CAK3fRr-cV_0c-sHhA2rMswrHEcLrkNfHs-=ejHRS8-j8zzObhA@mail.gmail.com>
From:   James Pearson <jcpearson@gmail.com>
Date:   Thu, 2 Jul 2020 11:28:18 +0100
Message-ID: <CAK3fRr_GR3bY5d6GC-cQYGN4UTR0nmkCyJa9AOgmSbxSxYWYEw@mail.gmail.com>
Subject: Re: NFSv4.0: client stuck looping on RENEW + NFSERR_STALE_CLIENTID
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 24 Jun 2020 at 09:54, James Pearson <jcpearson@gmail.com> wrote:
>
> On Wed, 10 Jun 2020 at 17:24, Robert Milkowski <rmilkowski@gmail.com> wrote:
> >
> > I was hoping someone here might get back with "hey, this has been fixed by
> > commit...".
> > We also did see it on centos 7.6
> >
> > I will try to get it re-produce it and once I can then I'll try to reproduce
> > it against upstream.
>
> I haven't been monitoring this list recently - but we are still having
> the same problem with CentOS 7.7 clients and Isilon filers
>
> I've just 'fixed' one client with the issue in the way you described
> earlier in this thread by looking for a process in nfs4_state_manager
> via a stack trace - killing that pid with -9 and all the stuck mount
> pops back to life

I have tcpdumps of when this RENEW/NFSERR_STALE_CLIENTID loop starts
taken on different clients - and all show a similar behaviour - from
one of these tcpdumps:

27803 2020-06-23 13:40:36 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
27804 2020-06-23 13:40:36 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 27803) RENEW
27815 2020-06-23 13:41:06 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
27816 2020-06-23 13:41:06 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 27815) RENEW
27827 2020-06-23 13:41:36 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
27828 2020-06-23 13:41:36 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 27827) RENEW
27856 2020-06-23 13:42:06 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
27857 2020-06-23 13:42:06 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 27856) RENEW
28071 2020-06-23 13:42:29 10.78.202.217 -> 10.78.196.220 NFS 110 V4
NULL Call[Malformed Packet]
28073 2020-06-23 13:42:29 10.78.196.220 -> 10.78.202.217 NFS 94 V4
NULL Reply (Call In 28071)[Malformed Packet]
28082 2020-06-23 13:42:29 10.78.202.217 -> 10.78.196.220 NFS 110 V4
NULL Call[Malformed Packet]
28084 2020-06-23 13:42:29 10.78.196.220 -> 10.78.202.217 NFS 94 V4
NULL Reply (Call In 28082)[Malformed Packet]
28086 2020-06-23 13:42:29 10.78.202.217 -> 10.78.196.220 NFS 370 V4
Call EXCHANGE_ID
28087 2020-06-23 13:42:29 10.78.196.220 -> 10.78.202.217 NFS 106 V4
Reply (Call In 28086) Status: NFS4ERR_MINOR_VERS_MISMATCH
28092 2020-06-23 13:42:29 10.78.202.217 -> 10.78.196.220 NFS 206 V4
Call PUTROOTFH | GETATTR
28093 2020-06-23 13:42:29 10.78.196.220 -> 10.78.202.217 NFS 342 V4
Reply (Call In 28092) PUTROOTFH | GETATTR
28095 2020-06-23 13:42:29 10.78.202.217 -> 10.78.196.220 NFS 258 V4
Call GETATTR FH: 0x2e47f02d
28096 2020-06-23 13:42:29 10.78.196.220 -> 10.78.202.217 NFS 162 V4
Reply (Call In 28095) GETATTR
28097 2020-06-23 13:42:29 10.78.202.217 -> 10.78.196.220 NFS 262 V4
Call GETATTR FH: 0x2e47f02d
28098 2020-06-23 13:42:29 10.78.196.220 -> 10.78.202.217 NFS 178 V4
Reply (Call In 28097) GETATTR
28099 2020-06-23 13:42:29 10.78.202.217 -> 10.78.196.220 NFS 258 V4
Call GETATTR FH: 0x2e47f02d
28100 2020-06-23 13:42:29 10.78.196.220 -> 10.78.202.217 NFS 162 V4
Reply (Call In 28099) GETATTR
...
39660 2020-06-23 13:42:53 10.78.202.217 -> 10.78.196.220 NFS 346 V4
Call LOOKUP DH: 0x19cf3646/shared
39661 2020-06-23 13:42:53 10.78.196.220 -> 10.78.202.217 NFS 342 V4
Reply (Call In 39660) LOOKUP
39663 2020-06-23 13:42:53 10.78.202.217 -> 10.78.196.220 NFS 314 V4
Call READLINK
39665 2020-06-23 13:42:53 10.78.196.220 -> 10.78.202.217 NFS 162 V4
Reply (Call In 39663) READLINK
44182 2020-06-23 13:42:56 10.78.202.217 -> 10.78.196.220 NFS 326 V4
Call GETATTR FH: 0xff288ce9
44183 2020-06-23 13:42:56 10.78.196.220 -> 10.78.202.217 NFS 266 V4
Reply (Call In 44182) GETATTR
68152 2020-06-23 13:42:59 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
68153 2020-06-23 13:42:59 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 68152) RENEW Status: NFS4ERR_STALE_CLIENTID
68155 2020-06-23 13:42:59 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
68156 2020-06-23 13:42:59 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 68155) RENEW Status: NFS4ERR_STALE_CLIENTID
73012 2020-06-23 13:43:04 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
73013 2020-06-23 13:43:04 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 73012) RENEW Status: NFS4ERR_STALE_CLIENTID
73270 2020-06-23 13:43:09 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
73271 2020-06-23 13:43:09 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 73270) RENEW Status: NFS4ERR_STALE_CLIENTID
73273 2020-06-23 13:43:14 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
73274 2020-06-23 13:43:14 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 73273) RENEW Status: NFS4ERR_STALE_CLIENTID
73276 2020-06-23 13:43:19 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
73277 2020-06-23 13:43:19 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 73276) RENEW Status: NFS4ERR_STALE_CLIENTID
73279 2020-06-23 13:43:24 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
73280 2020-06-23 13:43:24 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 73279) RENEW Status: NFS4ERR_STALE_CLIENTID

i.e. all clients have:

28071 2020-06-23 13:42:29 10.78.202.217 -> 10.78.196.220 NFS 110 V4
NULL Call[Malformed Packet]
28073 2020-06-23 13:42:29 10.78.196.220 -> 10.78.202.217 NFS 94 V4
NULL Reply (Call In 28071)[Malformed Packet]
28082 2020-06-23 13:42:29 10.78.202.217 -> 10.78.196.220 NFS 110 V4
NULL Call[Malformed Packet]
28084 2020-06-23 13:42:29 10.78.196.220 -> 10.78.202.217 NFS 94 V4
NULL Reply (Call In 28082)[Malformed Packet]
28086 2020-06-23 13:42:29 10.78.202.217 -> 10.78.196.220 NFS 370 V4
Call EXCHANGE_ID
28087 2020-06-23 13:42:29 10.78.196.220 -> 10.78.202.217 NFS 106 V4
Reply (Call In 28086) Status: NFS4ERR_MINOR_VERS_MISMATCH

then 30 seconds later, the RENEW/NFSERR_STALE_CLIENTID loop starts:

68152 2020-06-23 13:42:59 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
68153 2020-06-23 13:42:59 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 68152) RENEW Status: NFS4ERR_STALE_CLIENTID
68155 2020-06-23 13:42:59 10.78.202.217 -> 10.78.196.220 NFS 194 V4
Call RENEW CID: 0x3091
68156 2020-06-23 13:42:59 10.78.196.220 -> 10.78.202.217 NFS 114 V4
Reply (Call In 68155) RENEW Status: NFS4ERR_STALE_CLIENTID

Does anyone have any idea if the above might point to something that
has already been fixed in the mainline kernel?

Thanks

James Pearson

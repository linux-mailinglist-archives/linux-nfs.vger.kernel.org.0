Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6799670DF1B
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 16:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbjEWOU4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 10:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbjEWOUz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 10:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51417C4
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684851608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXevKoPQwiFGHwq9nGKjHKlx/3Ohg2Dgx/FXTwi5sJQ=;
        b=d97NPJWndgJXFZrqpoTJz9g8/BbRLg3K0uu/ozChkPPchILzTKXXj8XZVH7etddyJi95JP
        SUnLPH1WRNjFlXOR3Xsda0vgUm7JiK4MNr/bxEYrYN+zLvXfA6qstLJUT2NR8zvbxI2qNK
        omg4Bx1UwtRxaA+uHaWeM1ZiPmT0OvQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-N2ac3aJuNIW7GuFptIVuPA-1; Tue, 23 May 2023 10:16:26 -0400
X-MC-Unique: N2ac3aJuNIW7GuFptIVuPA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1ae515ff6a9so27582755ad.0
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 07:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851385; x=1687443385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXevKoPQwiFGHwq9nGKjHKlx/3Ohg2Dgx/FXTwi5sJQ=;
        b=FzHtXCakQBJmEN+UPVdI9tTWn4fnQoLwOoGzDLo0JM+C5tk4XN75POfSnn8PvR7ZMP
         A+RYv69/EgjS8SOvQf93Bhno4X8qzDRUrRctNqcn4XZHWLFOb2h4pcYVplvHuJUM5GYy
         guisESWiBPyu44O9070WTVikHVd1e4MPVj460a2LLus3isbKu/+ijMzS5PAtOlkNmt5R
         VjIWKM/RBWkWrfPsRwnNxxYtmSR+WHwsp0ShP0UxxeutqOedK/MDlMgdC2WwSMOTj4Tw
         5jnkVIiykcK+PJQW+M7UTdehZ5vw9+OeLFjcwBheEHs8F8Q/uMNWbeB4evUeAzJeyBpy
         vJpA==
X-Gm-Message-State: AC+VfDygcg3PDd4YXG6G20wmML6J+WVLrndsNfAuZ9ELlZsITZzV1J0o
        5Wrb7r61nHnytM0e7bg6ukaflIdXdPB0J/ZPykxioyEzmMDgJETWvsALIVPsebZfhejGPqN7aMN
        5CPRdw/UCboWTOLkyQwLf9DUYEh4WB3GIQqGQ
X-Received: by 2002:a17:903:22c2:b0:1ac:85b0:1bd8 with SMTP id y2-20020a17090322c200b001ac85b01bd8mr16543108plg.34.1684851384952;
        Tue, 23 May 2023 07:16:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7aCu6qjWZ7mqb2kw4apev+HbB34++pQI4nia2PrTT1D3sbB8KQocc/hRgFO03FObSCC2wmqneiVCfLu1dhpkk=
X-Received: by 2002:a17:903:22c2:b0:1ac:85b0:1bd8 with SMTP id
 y2-20020a17090322c200b001ac85b01bd8mr16543083plg.34.1684851384654; Tue, 23
 May 2023 07:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnUQs4r8fkW=6RW9g@mail.gmail.com>
 <1744185.1684489212@warthog.procyon.org.uk> <CAAmbk-ffz-6LqkEo+XavgiuefZK7BOHC7648ZhSs0BN88N=M4A@mail.gmail.com>
In-Reply-To: <CAAmbk-ffz-6LqkEo+XavgiuefZK7BOHC7648ZhSs0BN88N=M4A@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 23 May 2023 10:15:48 -0400
Message-ID: <CALF+zOmbORezpTam09CAvZmPu2KzwR==KNpA32xe90eVkSDK0g@mail.gmail.com>
Subject: Re: [Linux-cachefs] [BUG] fscache writing but not reading
To:     Chris Chilvers <chilversc@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Benjamin Maynard <benmaynard@google.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        brennandoyle@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 23, 2023 at 7:18=E2=80=AFAM Chris Chilvers <chilversc@gmail.com=
> wrote:
>
> On Fri, 19 May 2023 at 10:40, David Howells <dhowells@redhat.com> wrote:
> >
> > Chris Chilvers <chilversc@gmail.com> wrote:
> >
> > > While testing the fscache performance fixes [1] that were merged into=
 6.4-rc1
> > > it appears that the caching no longer works. The client will write to=
 the cache
> > > but never reads.
> >
> > Can you try reading from afs?  You would need to enable CONFIG_AFS_FS i=
n your
> > kernel if it's not already set.
> >
> > Install kafs-client and do:
> >
> >         systemctl enable afs.mount
> >         md5sum /afs/openafs.org/software/openafs/1.9.1/openafs-1.9.1-do=
c.tar.bz2
> >         cat /proc/fs/fscache/stats
>
> FS-Cache statistics
> Cookies: n=3D13 v=3D7 vcol=3D0 voom=3D0
> Acquire: n=3D13 ok=3D13 oom=3D0
> LRU    : n=3D1 exp=3D0 rmv=3D0 drp=3D0 at=3D2833
> Invals : n=3D0
> Updates: n=3D0 rsz=3D0 rsn=3D0
> Relinqs: n=3D0 rtr=3D0 drop=3D0
> NoSpace: nwr=3D0 ncr=3D0 cull=3D0
> IO     : rd=3D0 wr=3D18
> RdHelp : RA=3D18 RP=3D0 WB=3D0 WBZ=3D0 rr=3D0 sr=3D0
> RdHelp : ZR=3D1 sh=3D0 sk=3D0
> RdHelp : DL=3D18 ds=3D18 df=3D0 di=3D0
> RdHelp : RD=3D0 rs=3D0 rf=3D0
> RdHelp : WR=3D18 ws=3D18 wf=3D0
>
> This was on an instance that was only just created, so the cache was
> initially unused (all the counters were 0).
>
> >         umount /afs/openafs.org
> >         md5sum /afs/openafs.org/software/openafs/1.9.1/openafs-1.9.1-do=
c.tar.bz2
> >         cat /proc/fs/fscache/stats
>
> FS-Cache statistics
> Cookies: n=3D13 v=3D7 vcol=3D0 voom=3D0
> Acquire: n=3D26 ok=3D26 oom=3D0
> LRU    : n=3D1 exp=3D1 rmv=3D0 drp=3D0 at=3D467
> Invals : n=3D0
> Updates: n=3D0 rsz=3D0 rsn=3D0
> Relinqs: n=3D13 rtr=3D0 drop=3D13
> NoSpace: nwr=3D0 ncr=3D0 cull=3D0
> IO     : rd=3D18 wr=3D18
> RdHelp : RA=3D36 RP=3D0 WB=3D0 WBZ=3D0 rr=3D0 sr=3D0
> RdHelp : ZR=3D1 sh=3D0 sk=3D0
> RdHelp : DL=3D18 ds=3D18 df=3D0 di=3D0
> RdHelp : RD=3D18 rs=3D18 rf=3D0
> RdHelp : WR=3D18 ws=3D18 wf=3D0
>
> Looks like the cache is working fine with AFS. The second md5sum
> seemed a lot quicker than the first.
>
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
>

I don't think this test demonstrates the failure Chris is seeing, or
correct me if I'm wrong Chris.

Chris, does this same test fail for you with NFS on 6.4-rc1?  The same
test passes for me with NFSv3.
1st time through: writes to the cache seen, no reads: IO     : rd=3D0 wr=3D=
16
2nd time through: reads from the cache seen, no writes: IO     : rd=3D16 wr=
=3D16


# mount -o vers=3D3,fsc 127.0.0.1:/export/ /mnt/nfs
# cat /proc/fs/fscache/stats
FS-Cache statistics
Cookies: n=3D0 v=3D1 vcol=3D0 voom=3D0
Acquire: n=3D0 ok=3D0 oom=3D0
LRU    : n=3D0 exp=3D0 rmv=3D0 drp=3D0 at=3D0
Invals : n=3D0
Updates: n=3D0 rsz=3D0 rsn=3D0
Relinqs: n=3D0 rtr=3D0 drop=3D0
NoSpace: nwr=3D0 ncr=3D0 cull=3D0
IO     : rd=3D0 wr=3D0
RdHelp : RA=3D0 RP=3D0 WB=3D0 WBZ=3D0 rr=3D0 sr=3D0
RdHelp : ZR=3D0 sh=3D0 sk=3D0
RdHelp : DL=3D0 ds=3D0 df=3D0 di=3D0
RdHelp : RD=3D0 rs=3D0 rf=3D0
RdHelp : WR=3D0 ws=3D0 wf=3D0
# md5sum /mnt/nfs/openafs-1.9.1-doc.tar.bz2
ca25530ec01afc3b71bc081bc93b87cf  /mnt/nfs/openafs-1.9.1-doc.tar.bz2
# cat /proc/fs/fscache/stats
FS-Cache statistics
Cookies: n=3D1 v=3D1 vcol=3D0 voom=3D0
Acquire: n=3D1 ok=3D1 oom=3D0
LRU    : n=3D1 exp=3D0 rmv=3D0 drp=3D0 at=3D6444
Invals : n=3D0
Updates: n=3D1 rsz=3D0 rsn=3D0
Relinqs: n=3D0 rtr=3D0 drop=3D0
NoSpace: nwr=3D0 ncr=3D0 cull=3D0
IO     : rd=3D0 wr=3D16
RdHelp : RA=3D16 RP=3D0 WB=3D0 WBZ=3D0 rr=3D0 sr=3D0
RdHelp : ZR=3D1 sh=3D0 sk=3D0
RdHelp : DL=3D16 ds=3D16 df=3D0 di=3D0
RdHelp : RD=3D0 rs=3D0 rf=3D0
RdHelp : WR=3D16 ws=3D16 wf=3D0
# umount /mnt/nfs
# mount -o vers=3D3,fsc 127.0.0.1:/export/ /mnt/nfs
# md5sum /mnt/nfs/openafs-1.9.1-doc.tar.bz2
ca25530ec01afc3b71bc081bc93b87cf  /mnt/nfs/openafs-1.9.1-doc.tar.bz2
# cat /proc/fs/fscache/stats
FS-Cache statistics
Cookies: n=3D1 v=3D1 vcol=3D0 voom=3D0
Acquire: n=3D2 ok=3D2 oom=3D0
LRU    : n=3D1 exp=3D1 rmv=3D0 drp=3D0 at=3D6710
Invals : n=3D0
Updates: n=3D2 rsz=3D0 rsn=3D0
Relinqs: n=3D1 rtr=3D0 drop=3D1
NoSpace: nwr=3D0 ncr=3D0 cull=3D0
IO     : rd=3D16 wr=3D16
RdHelp : RA=3D32 RP=3D0 WB=3D0 WBZ=3D0 rr=3D0 sr=3D0
RdHelp : ZR=3D1 sh=3D0 sk=3D0
RdHelp : DL=3D16 ds=3D16 df=3D0 di=3D0
RdHelp : RD=3D16 rs=3D16 rf=3D0
RdHelp : WR=3D16 ws=3D16 wf=3D0
# uname -r
6.4.0-rc1


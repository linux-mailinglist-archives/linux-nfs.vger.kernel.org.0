Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832AB69FCEA
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 21:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjBVUOt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 15:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjBVUOt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 15:14:49 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE535303ED
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 12:14:23 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id a26so5208011pfo.9
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 12:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKFPmA4UhQdH5hNgzzq5nwM+JEsgF6eFTPWiUpdLOew=;
        b=FSERntg+d3+MlROlmvRiYKd5mDWM304cKRerBbEhUmY0xrXvEh37GNNm/6KGHPKG9d
         JH4FOWLkdkgBXThPgSlkudPmSF3ESfoK29sF+Sg3rAv6CLiVngk4fRSkfcboOZfNTWAO
         wgqVTXe+ZN9NWu78l4XpVNDUCwl8v/QapF3fxJpDC/HcXKc9Crb1wy+CE0z1/KzXO15j
         tw84v9wEMwWdp0Y+BQOEIO/Q0a8nTt/jC4wiB98YXAit0DZfR7CbgeF+DtaXY35Z1GoB
         TSfEQKGUekEXmhvieQ6ywomsitZz9SXkfJumKNsDoxENgFZCwRyHmG+gwLXRCdxRHv0J
         mLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKFPmA4UhQdH5hNgzzq5nwM+JEsgF6eFTPWiUpdLOew=;
        b=wb5sSChH/OaCK7MrF0xgqQKtxM9MOmGWL8NC/maVakoo3dVD3MqStlC6HKOhTUSh/H
         p8YIFg7BkitayFHEETDSyNJw/WYabDmaXOOR5RfB0aZHpXqeKa1MS4Qk7Vm3EDAn1Xfr
         wEHWee/6rKRwn2hA2atFokUGi5gykKF9/LS5vM6PorlTkGOXO7htwhMPfyyiuxV+yHcu
         rSrvVxzKsN7AFuWYER2FKWVuAikgBuGPyp8TObc7A4PGOedEXVUxU7LQUBk14YEvDiA/
         rUpGsimjpZH0zo/Jl9IjSSeKSlfwU0dYnRB8iXy1qBp3phH63zQCSqHPNzN9WmWTAwqY
         FiRA==
X-Gm-Message-State: AO0yUKVE6BrbiPCBtscq72WSLT6r9QFvtVhcnKeTkirOy2bqkidObHEi
        0wLrJ0FlCqbap6ikvqF7Lkk8hF9iF/hSUCuajvVKtMRdQQ==
X-Google-Smtp-Source: AK7set8is/vBSxsW5M/pltnhwE7tdOvvaQ9R5v80jpCpccG2BNPhcFiZp2PSjHJoOtmrT3uVQjGxzHoklFqtJSUrMWU=
X-Received: by 2002:a05:6a00:2a9:b0:593:a89e:a992 with SMTP id
 q9-20020a056a0002a900b00593a89ea992mr1436058pfs.2.1677096858146; Wed, 22 Feb
 2023 12:14:18 -0800 (PST)
MIME-Version: 1.0
References: <59682160-a246-395a-9486-9bbf11686740@mathematik.uni-wuerzburg.de>
 <8a02c86882bc47c1c1387dba8c7d756237cb3f3f.camel@kernel.org>
 <3b6c9b8e-2795-74e8-aefa-d4f1ac007c3c@mathematik.uni-wuerzburg.de>
 <785052D6-E39F-40D3-8BA3-72D3940EDD84@redhat.com> <7c7de5f1-fb6a-e970-99a2-4880583d8f6d@mathematik.uni-wuerzburg.de>
 <1B586C15-908C-4B00-9739-9AD118F88BD4@redhat.com> <4f70c2f5-dfdb-c37c-8663-5f2a108e229e@mathematik.uni-wuerzburg.de>
 <5AB8B0FE-5D7E-4ED4-9537-979341C6371A@redhat.com> <90861fe9716ab35f52b136f533ac693eb3d86279.camel@kernel.org>
 <550d9137-8d59-5be1-23be-34c6e1dff99a@mathematik.uni-wuerzburg.de> <90503D13-F731-49E7-B9F9-6722E9A200AC@redhat.com>
In-Reply-To: <90503D13-F731-49E7-B9F9-6722E9A200AC@redhat.com>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Wed, 22 Feb 2023 12:14:02 -0800
Message-ID: <CAM5tNy70X-byLfSu3UHoiT-h=OVjVkMOZgFgiOmR4urYmv1SHg@mail.gmail.com>
Subject: Re: Reoccurring 5 second delays during NFS calls
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     =?UTF-8?Q?Florian_M=C3=B6ller?= 
        <fmoeller@mathematik.uni-wuerzburg.de>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Andreas Seeg <andreas.seeg@mathematik.uni-wuerzburg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 22, 2023 at 11:44 AM Benjamin Coddington
<bcodding@redhat.com> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca
>
>
> On 22 Feb 2023, at 7:48, Florian M=C3=B6ller wrote:
>
> > Am 22.02.23 um 13:22 schrieb Jeff Layton:
> >> On Wed, 2023-02-22 at 06:54 -0500, Benjamin Coddington wrote:
> >>> On 22 Feb 2023, at 3:19, Florian M=C3=B6ller wrote:
> >>>
> >>>> Am 21.02.23 um 19:58 schrieb Benjamin Coddington:
> >>>>> On 21 Feb 2023, at 11:52, Florian M=C3=B6ller wrote:
> >>>>>
> >>>>>> Hi Benjamin,
> >>>>>>
> >>>>>> here are the trace and a listing of the corresponding network pack=
ages. If the listing is not detailed enough, I can send you a full package =
dump tomorrow.
> >>>>>>
> >>>>>> The command I used was
> >>>>>>
> >>>>>> touch test.txt && sleep 2 && touch test.txt
> >>>>>>
> >>>>>> test.txt did not exist previously. So you have an example of a tou=
ch without and with delay.
> >>>>>
> >>>>> Thanks!  These are great - I can see from them that the client is i=
ndeed
> >>>>> waiting in the stateid update mechanism because the server has retu=
rned
> >>>>> NFS4ERR_STALE to the client's first CLOSE.
> >>>>>
> >>>>> That is unusual.  The server is signaling that the open file's stat=
eid is old,
> >>>>> so I am interested to see if the first CLOSE is sent with the state=
id's
> >>>>> sequence that was returned from the server.  I could probably see t=
his if I
> >>>>> had the server-side tracepoint data.
> >>>>
> >>>> Hi Benjamin,
> >>>>
> >>>> the server-side tracepoints
> >>>>
> >>>> nfsd:nfsd_preprocess
> >>>> sunrpc:svc_process
> >>>>
> >>>> were enabled. It seems they did not produce any output.
> >>>>
> >>>> What I did now was:
> >>>> - enable all nfsd tracepoints,
> >>>> - enable all nfs4 tracepoints,
> >>>> - enable all sunrpc tracepoints.
> >>>>
> >>>> The command I used was
> >>>>
> >>>> touch somefile && sleep 2 && touch somefile.
> >>>>
> >>>> Then I unmounted the NFS share - this also causes a delay.
> >>>>
> >>>> I changed the security type to krb5 and captured trace and network o=
utput for a version 4.0 and a version 4.2 mount. The delay does not occur w=
hen using version 4.0.
> >>>
> >>>
> >>> In frame 9 of nfs-v4.2-krb5.pcap, the server responds to PUTFH with
> >>> NFS4ERR_STALE, so nothing to do with the open stateid sequencing.  I =
also
> >>> see:
> >>>
> >>> nfsd-1693    [000] .....  1951.353889: nfsd_exp_find_key: fsid=3D1::{=
0x0,0xe5fcf0,0xffffc900,0x811e87a3,0xffffffff,0xe5fd00} domain=3Dgss/krb5i =
status=3D-2
> >>> nfsd-1693    [000] .....  1951.353889: nfsd_set_fh_dentry_badexport: =
xid=3D0xe1511810 fh_hash=3D0x3f9e713a status=3D-2
> >>> nfsd-1693    [000] .....  1951.353890: nfsd_compound_status: op=3D2/4=
 OP_PUTFH status=3D70
> >>>
> >>
> >> This just means that the kernel called into the "cache" infrastructure
> >> to find an export entry, and there wasn't one.
> >>
> >>
> >> Looking back at the original email here, I'd say this is expected sinc=
e
> >> the export wasn't set up for krb5i.
> >>
> >> Output of exportfs -v:
> >> /export
> >> gss/krb5p(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,sec=3Ds=
ys,rw,secure,root_squash,no_all_squash)
> >> /export
> >> gss/krb5(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,sec=3Dsy=
s,rw,secure,root_squash,no_all_squash)
> >
> > I changed the export definitions to
> >
> > /export gss/krb5(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,s=
ec=3Dsys,rw,secure,root_squash,no_all_squash)
> > /export gss/krb5i(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,=
sec=3Dsys,rw,secure,root_squash,no_all_squash)
> > /export gss/krb5p(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,=
sec=3Dsys,rw,secure,root_squash,no_all_squash)
> >
> > such that all three kerberos security types are exported. With this set=
up the delay is gone. Without the krb5i export the delay occurs again.
> > Mounting the NFS share with different kerberos security types does not =
change this behaviour - without the krb5i export there is a delay.
>
> After getting the ol' KDC back in shape and trying to reproduce this, I
> noticed you're using a client specifier that's been deprecated (the
> gss/krb5), along with sec=3Dsys in the same line.  That's a little weird,=
 not
> sure what the results of that might be.
>
> I can't even get any mount to work with that:
>
> [root@fedora ~]# exportfs -v
> /exports        gss/krb5(sync,wdelay,hide,no_subtree_check,nordirplus,fsi=
d=3D0,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
> /exports        gss/krb5p(sync,wdelay,hide,no_subtree_check,nordirplus,fs=
id=3D0,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
> [root@fedora ~]# mount -t nfs -ov4.1,sec=3Dkrb5 fedora.fh.bcodding.com:/e=
xports /mnt/fedora
> mount.nfs: mounting fedora.fh.bcodding.com:/exports failed, reason given =
by server: No such file or directory
>
> However, if I use the "sec=3D" method, everything seems to work fine:
>
> [root@fedora ~]# exportfs -v
> /exports        10.0.1.0/24(sync,wdelay,hide,no_subtree_check,nordirplus,=
sec=3Dsys:krb5:krb5p,rw,insecure,no_root_squash,no_all_squash)
> [root@fedora ~]# mount -t nfs -ov4.1,sec=3Dkrb5 fedora.fh.bcodding.com:/e=
xports /mnt/fedora
> [root@fedora ~]# touch /mnt/fedora/krbfoo
> [root@fedora ~]# touch /mnt/fedora/krbfoo
> [root@fedora ~]# umount /mnt/fedora
> [root@fedora ~]# mount -t nfs -ov4.1,sec=3Dkrb5p fedora.fh.bcodding.com:/=
exports /mnt/fedora
> [root@fedora ~]# touch /mnt/fedora/krbfoo
> [root@fedora ~]# touch /mnt/fedora/krbfoo
> [root@fedora ~]# umount /mnt/fedora
>
> .. so I can't seem to reproduce this because I can't even mount.  Did you
> perhaps have a previous mount with that client with a different security
> flavor?
>
> I think your NFS client ended up having a machine credential with krb5i, =
but
> then the export with that flavor was removed.  When the client tried to d=
o a
> CLOSE, it picked the machine cred, which caused the server to fail in the
> lookup of the export, which caused the client to think its stateid was
> wrong.
>
Just a shot in the dark, but is the client deciding to use SP4_MACH_CRED?
If so (and the server allows it by replying NFS_OK to ExchangeID), then the
client must use krb5i or krb5p for the state maintenance operations.
Easy to check. Just look at the ExchangeID done at mount time with wireshar=
k.

rick

> Ben
>

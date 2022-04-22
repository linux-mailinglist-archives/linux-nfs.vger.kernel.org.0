Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BDC50BA0B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Apr 2022 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448376AbiDVO1K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Apr 2022 10:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbiDVO1H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Apr 2022 10:27:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0035B3E2
        for <linux-nfs@vger.kernel.org>; Fri, 22 Apr 2022 07:24:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b24so10610106edu.10
        for <linux-nfs@vger.kernel.org>; Fri, 22 Apr 2022 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHzLhkhHkakLFMYYtV3u4+8tFMzvScBZKM2iM56yylI=;
        b=NEhFJ5EDJCcayVfMK5GLcJSgXkNwIOOK4Q4azuCRqmjLHm6yTrpEsKwcGYh7C/kZez
         A38R4+nuhSmFC85N/2lcGyOvCUqksd5wcZzNEGmTxC4JVw/hbEg/Q8hSsSV4T6VCp9HN
         I1Kox+69wW62A3QEut+TiH45NIftGrXDFsNYAQmDRJAEBn5Ml9Oo5fGaphkepF1Vk28d
         CdxD4+zRBVWuGrZoP9oZeBINf9ldLSgfdMdg1eNG+Zg0HjeuBny6OsL3h5deJpEu2hg0
         s3ITm1rQYRoVqhn2+zeiVX5jh5NdnT+u3gP6jgAFuLxGhD4DRHGUnmCkbgveXldKSTLH
         aOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHzLhkhHkakLFMYYtV3u4+8tFMzvScBZKM2iM56yylI=;
        b=jDR9QakYpTAIaIL2Hz+MeLUw1ypfhjVXcQJuJvpWDZSpFrsPeQNr0fkUWfGisyCZcr
         sjYsxV2lXRdUl/GuReX++RM/1d9+QWGrXXISVUNN5awTDNQOFRBRfy4a/0zMQQv1W1X7
         QvvxqHhcg4AEAAWQlWVA4zqpSb9PN9dcrWbZPbRNQSntOavnqb8YB3bCl09alBOtqOxO
         zLnRuktLrz4LLaPcQxwlDhyFlYyL8Kxkuv982TzAQG3sIex/4WjyxSijB119l1aPIC9V
         LsE0baQI+d7MCMIEPnfF928yWjeRTc+4suhyy9x8AmJAJ3mofjCgjQrwU0Snjek5cGjn
         xeMg==
X-Gm-Message-State: AOAM531MXjSdyHjHn3wRENIUW2R5sjKeEthiM6onpJ79O4E92GSfTIlp
        oFHPYEVhy6coX62geE5xPOSdpd7ObZqZZOtoj0w=
X-Google-Smtp-Source: ABdhPJwLZUKtlLKiZNWtoE7RMyDU32r8nqv2sLO2OvUJENI5JU2GjrqZ8UrSJ8hdUSlR2A/xp/JgBJBuKX8jtWV8wrI=
X-Received: by 2002:a05:6402:50cc:b0:424:20a7:4a0f with SMTP id
 h12-20020a05640250cc00b0042420a74a0fmr4975672edb.209.1650637451120; Fri, 22
 Apr 2022 07:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com> <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
In-Reply-To: <20220421185423.GD18620@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 22 Apr 2022 10:23:59 -0400
Message-ID: <CAN-5tyGC8Bf8E0u2=8_1xjCKNqM4B89RbtktqXGg++YbyEirTg@mail.gmail.com>
Subject: Re: Problems with NFS4.1 on ESXi
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "crispyduck@outlook.at" <crispyduck@outlook.at>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 22, 2022 at 8:59 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, Apr 21, 2022 at 12:40:49PM -0400, bfields wrote:
> > On Thu, Apr 21, 2022 at 03:30:19PM +0000, crispyduck@outlook.at wrote:
> > > Thanks. From VMWare side nobody will help here as this is not supported. They support NFS4.1, but officially only from some storage vendors.
> > >
> > > I had it running in the past on FreeBSD, where I also some problems in the beginning  (RECLAIM_COMPLETE) and Rick Macklem helped to figure out the problem and fixed it with some patches that should now be part of FreeBSD.
> > >
> > > I plan to use it with ZFS, but also tested it on ext4, with exact same behavior.
> > >
> > > NFS3 works fine, NFS4.1 seems to work fine, except the described problems.
> > >
> > > The reason for NFS4.1 is session trunking, which gives really awesome speeds when using multiple NICs/subnets. Comparable to ISCSI.
> > > ANFS4.1 based storage for ESXi and other Hypervisors.
> > >
> > > The test is also done without session trunking.
> > >
> > > This needs NFS expertise, no idea where else i could ask to have a look on the traces.
> >
> > Stale filehandles aren't normal, and suggest some bug or
> > misconfiguration on the server side, either in NFS or the exported
> > filesystem.
>
> Actually, I should take that back: if one client removes files while a
> second client is using them, it'd be normal for applications on that
> second client to see ESTALE.

I looked at the traces and they looked OK to me. The ESTALE was from
the vmware client sending a RENAME onto a file that was opened
previously and then sending a CLOSE on that filehandle which resulted
in ESTALE. So something like this:
OPEN (foobar)
RENAME (something else, foobar)
CLOSE (foobar) leads to ESTALE

I agree with Chuck's suggestion which was to ask vmware support.

> So it might be interesting to know what actually happens when VM
> templates are imported.
>
> I suppose you could also try NFSv4.0 or try varying kernel versions to
> try to narrow down the problem.
>
> No easy ideas off the top of my head, sorry.
>
> --b.
>
> > Figuring out more than that would require more
> > investigation.
> >
> > --b.
> >
> > >
> > > Br,
> > > Andi
> > >
> > >
> > >
> > >
> > >
> > >
> > > Von: Chuck Lever III <chuck.lever@oracle.com>
> > > Gesendet: Donnerstag, 21. April 2022 16:58
> > > An: Andreas Nagy <crispyduck@outlook.at>
> > > Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> > > Betreff: Re: Problems with NFS4.1 on ESXi
> > >
> > > Hi Andreas-
> > >
> > > > On Apr 21, 2022, at 12:55 AM, Andreas Nagy <crispyduck@outlook.at> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I hope this mailing list is the right place to discuss some problems with nfs4.1.
> > >
> > > Well, yes and no. This is an upstream developer mailing list,
> > > not really for user support.
> > >
> > > You seem to be asking about products that are currently supported,
> > > and I'm not sure if the Debian kernel is stock upstream 5.13 or
> > > something else. ZFS is not an upstream Linux filesystem and the
> > > ESXi NFS client is something we have little to no experience with.
> > >
> > > I recommend contacting the support desk for your products. If
> > > they find a specific problem with the Linux NFS server's
> > > implementation of the NFSv4.1 protocol, then come back here.
> > >
> > >
> > > > Switching from FreeBSD host as NFS server to a Proxmox environment also serving NFS I see some strange issues in combination with VMWare ESXi.
> > > >
> > > > After first thinking it works fine, I started to realize that there are problems with ESXi datastores on NFS4.1 when trying to import VMs (OVF).
> > > >
> > > > Importing ESXi OVF VM Templates fails nearly every time with a ESXi error message "postNFCData failed: Not Found". With NFS3 it is working fine.
> > > >
> > > > NFS server is running on a Proxmox host:
> > > >
> > > >  root@sepp-sto-01:~# hostnamectl
> > > >  Static hostname: sepp-sto-01
> > > >  Icon name: computer-server
> > > >  Chassis: server
> > > >  Machine ID: 028da2386e514db19a3793d876fadf12
> > > >  Boot ID: c5130c8524c64bc38994f6cdd170d9fd
> > > >  Operating System: Debian GNU/Linux 11 (bullseye)
> > > >  Kernel: Linux 5.13.19-4-pve
> > > >  Architecture: x86-64
> > > >
> > > >
> > > > File system is ZFS, but also tried it with others and it is the same behaivour.
> > > >
> > > >
> > > > ESXi version 7.2U3
> > > >
> > > > ESXi vmkernel.log:
> > > > 2022-04-19T17:46:38.933Z cpu0:262261)cswitch: L2Sec_EnforcePortCompliance:209: [nsx@6876 comp="nsx-esx" subcomp="vswitch"]client vmk1 requested promiscuous mode on port 0x4000010, disallowed by vswitch policy
> > > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)World: 12075: VC opID esxui-d6ab-f678 maps to vmkernel opID 936118c3
> > > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)WARNING: NFS41: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fce02850 failed: Stale file handle
> > > > 2022-04-19T17:46:40.897Z cpu10:266351 opID=936118c3)WARNING: NFS41: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> > > > 2022-04-19T17:46:41.164Z cpu4:266351 opID=936118c3)WARNING: NFS41: NFS41FileDoCloseFile:3128: file handle close on obj 0x4303fcdaa000 failed: Stale file handle
> > > > 2022-04-19T17:46:41.164Z cpu4:266351 opID=936118c3)WARNING: NFS41: NFS41FileOpCloseFile:3718: NFS41FileCloseFile failed: Stale file handle
> > > > 2022-04-19T17:47:25.166Z cpu18:262376)ScsiVmas: 1074: Inquiry for VPD page 00 to device mpx.vmhba32:C0:T0:L0 failed with error Not supported
> > > > 2022-04-19T17:47:25.167Z cpu18:262375)StorageDevice: 7059: End path evaluation for device mpx.vmhba32:C0:T0:L0
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)World: 12075: VC opID esxui-6787-f694 maps to vmkernel opID 9529ace7
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: 209: Creating crypto hash
> > > > 2022-04-19T17:47:30.645Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2465: Evicting VM with path:/vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: 209: Creating crypto hash
> > > > 2022-04-19T17:47:30.693Z cpu4:264565 opID=9529ace7)VmMemXfer: vm 264565: 2479: Could not find MemXferFS region for /vmfs/volumes/9f10677f-697882ed-0000-000000000000/test-ovf/test-ovf.vmx
> > > >
> > > > tcpdump taken on the esxi with filter on the nfs server ip is attached here:
> > > > https://easyupload.io/xvtpt1
> > > >
> > > > I tried to analyze, but have no idea what exactly the problem is. Maybe it is some issue with the VMWare implementation?
> > > > Would be nice if someone with better NFS knowledge could have a look on the traces.
> > > >
> > > > Best regards,
> > > > cd
> > >
> > > --
> > > Chuck Lever
> > >

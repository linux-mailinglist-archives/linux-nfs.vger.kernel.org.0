Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9869F474
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 13:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjBVMXp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 07:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjBVMXo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 07:23:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537C23A849
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 04:23:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D62B46137C
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 12:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3781C433D2;
        Wed, 22 Feb 2023 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677068523;
        bh=VK7qMpraJBniZzT34rzr3XSWr7bqz9SZCFBaCOskxTs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UYMNfQnkGTeaySKYjjmFAaIMcDQykUNA+Ra2zu5/mw6jL91nUL+HUFxDHIAVLNCMA
         Zbx40IKPpLpMzLMPAuqxok7lFffVHCyZH54cI7ymgELjj93MsF4W14Q3IvL5gbqX/x
         jmEAe65M259AcmkdWNdlJ5Sb0EJVFjPjeZMl5rDw4s6fU5vD/KjSF7rGwuupDICuB6
         rCCir9q6l8xARmcrlccjvS5+gdnH3pVj81jATQXW/+yQQaJ041/kpRGZvXYk/zhgGD
         /cTnjF92bvfSBhOZtUN0j1Rpfc5CtY6HLdJ/30eNUV6N9b+A5uSnZNuVe/cLPTcOr9
         vpKBi4z2fueRQ==
Message-ID: <90861fe9716ab35f52b136f533ac693eb3d86279.camel@kernel.org>
Subject: Re: Reoccurring 5 second delays during NFS calls
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>,
        Florian =?ISO-8859-1?Q?M=F6ller?= 
        <fmoeller@mathematik.uni-wuerzburg.de>
Cc:     linux-nfs@vger.kernel.org,
        Andreas Seeg <andreas.seeg@mathematik.uni-wuerzburg.de>
Date:   Wed, 22 Feb 2023 07:22:01 -0500
In-Reply-To: <5AB8B0FE-5D7E-4ED4-9537-979341C6371A@redhat.com>
References: <59682160-a246-395a-9486-9bbf11686740@mathematik.uni-wuerzburg.de>
         <8a02c86882bc47c1c1387dba8c7d756237cb3f3f.camel@kernel.org>
         <3b6c9b8e-2795-74e8-aefa-d4f1ac007c3c@mathematik.uni-wuerzburg.de>
         <785052D6-E39F-40D3-8BA3-72D3940EDD84@redhat.com>
         <7c7de5f1-fb6a-e970-99a2-4880583d8f6d@mathematik.uni-wuerzburg.de>
         <1B586C15-908C-4B00-9739-9AD118F88BD4@redhat.com>
         <4f70c2f5-dfdb-c37c-8663-5f2a108e229e@mathematik.uni-wuerzburg.de>
         <5AB8B0FE-5D7E-4ED4-9537-979341C6371A@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-02-22 at 06:54 -0500, Benjamin Coddington wrote:
> On 22 Feb 2023, at 3:19, Florian M=F6ller wrote:
>=20
> > Am 21.02.23 um 19:58 schrieb Benjamin Coddington:
> > > On 21 Feb 2023, at 11:52, Florian M=F6ller wrote:
> > >=20
> > > > Hi Benjamin,
> > > >=20
> > > > here are the trace and a listing of the corresponding network packa=
ges. If the listing is not detailed enough, I can send you a full package d=
ump tomorrow.
> > > >=20
> > > > The command I used was
> > > >=20
> > > > touch test.txt && sleep 2 && touch test.txt
> > > >=20
> > > > test.txt did not exist previously. So you have an example of a touc=
h without and with delay.
> > >=20
> > > Thanks!  These are great - I can see from them that the client is ind=
eed
> > > waiting in the stateid update mechanism because the server has return=
ed
> > > NFS4ERR_STALE to the client's first CLOSE.
> > >=20
> > > That is unusual.  The server is signaling that the open file's statei=
d is old,
> > > so I am interested to see if the first CLOSE is sent with the stateid=
's
> > > sequence that was returned from the server.  I could probably see thi=
s if I
> > > had the server-side tracepoint data.
> >=20
> > Hi Benjamin,
> >=20
> > the server-side tracepoints
> >=20
> > nfsd:nfsd_preprocess
> > sunrpc:svc_process
> >=20
> > were enabled. It seems they did not produce any output.
> >=20
> > What I did now was:
> > - enable all nfsd tracepoints,
> > - enable all nfs4 tracepoints,
> > - enable all sunrpc tracepoints.
> >=20
> > The command I used was
> >=20
> > touch somefile && sleep 2 && touch somefile.
> >=20
> > Then I unmounted the NFS share - this also causes a delay.
> >=20
> > I changed the security type to krb5 and captured trace and network outp=
ut for a version 4.0 and a version 4.2 mount. The delay does not occur when=
 using version 4.0.
>=20
>=20
> In frame 9 of nfs-v4.2-krb5.pcap, the server responds to PUTFH with
> NFS4ERR_STALE, so nothing to do with the open stateid sequencing.  I also
> see:
>=20
> nfsd-1693    [000] .....  1951.353889: nfsd_exp_find_key: fsid=3D1::{0x0,=
0xe5fcf0,0xffffc900,0x811e87a3,0xffffffff,0xe5fd00} domain=3Dgss/krb5i stat=
us=3D-2
> nfsd-1693    [000] .....  1951.353889: nfsd_set_fh_dentry_badexport: xid=
=3D0xe1511810 fh_hash=3D0x3f9e713a status=3D-2
> nfsd-1693    [000] .....  1951.353890: nfsd_compound_status: op=3D2/4 OP_=
PUTFH status=3D70
>=20

This just means that the kernel called into the "cache" infrastructure
to find an export entry, and there wasn't one.=20


Looking back at the original email here, I'd say this is expected since
the export wasn't set up for krb5i.

Output of exportfs -v:
/export=20
gss/krb5p(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,sec=3Dsys,rw=
,secure,root_squash,no_all_squash)
/export=20
gss/krb5(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,sec=3Dsys,rw,=
secure,root_squash,no_all_squash)


>=20
> .. so nfsd's exp_find_key() is having trouble and returns -ENOENT.  Does
> this look familiar to anyone?
>=20
> I am not as familiar with how the server operates here, so my next step
> would be to start inserting trace_printk's into the kernel source to figu=
re
> out what's going wrong in there.  However, we can also use the function
> graph tracer to see where the kernel is going.  That would look like:
>=20
>  echo exp_find_key > /sys/kernel/tracing/set_graph_function
>  echo 7 > /sys/kernel/debug/tracing/max_graph_depth
>  echo function_graph > /sys/kernel/debug/tracing/current_tracer
> > /sys/kernel/debug/tracing/trace
>=20
>  .. reproduce
>=20
>  cat /sys/kernel/debut/tracing/trace
>=20
> Hopefully someone with more knfsd/sunrpc experience recognizes this.. but=
 it
> makes a lot more sense now that krb5 is part of the problem.
>=20
> Ben
>=20

--=20
Jeff Layton <jlayton@kernel.org>

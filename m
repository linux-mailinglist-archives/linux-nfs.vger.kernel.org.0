Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734A868351F
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 19:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjAaSYF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 13:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjAaSYE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 13:24:04 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 10:24:03 PST
Received: from mta-102a.earthlink-vadesecure.net (mta-102b.earthlink-vadesecure.net [51.81.61.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94B402C7
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 10:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=PVCpcDs7YShv4v5+fflD35/EHzAcpr+3SU30s7
 qYj4c=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1675189136;
 x=1675793936; b=c1h9XG3PK8EZU8AK//4qyuNDMLLb/jkzFRn4wCO67qIAlHetnCxpVXt
 /1/BDBki1inagbT/tUsr0EbHUhajkon0Duja+QyJK7G6Ca8xj498CVEstbliqTD+ffUjVGF
 1K84mxbNt9J89Clnb6fVBQu49C3uSpu1i+iWd6gtFNnDBT0UaJIQL708i3Udkf/+4mxu1on
 qG83Q1q4zaXMSwHYXSQwRKMTajUD2yaulxdZh6ir9CcTb7kYVMBJvpoSvNhrvsz8gUabkza
 Gcpzs9xb6ClrdIkOgkohm5TAGF3CP/TOylAcO6qhT8qYoN2FBVAEEkVU0A4h+hjATbiXBwx
 IKQ==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by smtp.earthlink-vadesecure.net ESMTP vsel1nmtao02p with ngmta
 id d3bb2214-173f77a4b30a91a2; Tue, 31 Jan 2023 18:18:56 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Olga Kornievskaia'" <aglo@umich.edu>,
        "'Andrew J. Romero'" <romero@fnal.gov>
Cc:     <linux-nfs@vger.kernel.org>
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM> <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM> <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM> <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org> <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM> <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org> <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM> <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org> <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com> <CAN-5tyFro=naMgub9uAZ0wa20WhZwV2Rh6xv_meNice1EG+Dug@mail.gmail.com>
In-Reply-To: <CAN-5tyFro=naMgub9uAZ0wa20WhZwV2Rh6xv_meNice1EG+Dug@mail.gmail.com>
Subject: RE: Zombie / Orphan open files
Date:   Tue, 31 Jan 2023 10:18:55 -0800
Message-ID: <046e01d935a0$7b3a2d30$71ae8790$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQHKHeKiOFZ2WRsyrUPH+SLMUFdhGAMJermdAk/uKvkBsYTADAE8xzQBATE5vK8BW2v3PgLMDpYtAf9tvNsAuV3PQK5UOZ/g
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Mon, Jan 30, 2023 at 5:44 PM Andrew J. Romero <romero@fnal.gov> =
wrote:
> >
> > Hi
> >
> > This is a quick general NFS server question.
> >
> > Does the NFSv4x  specification require or recommend that:   the NFS =
server,
> after some reasonable time,
> > should / must close orphan / zombie open files ?
>=20
> Why should the server be responsible for a badly behaving client? It =
seems like
> you are advocating for the world where a problem is hidden rather than =
solved.
> But because bugs do occur and some customers want a quick solution, =
some
> storage providers do have ways of dealing with releasing resources =
(like open
> state) that the client will never ask for again.
>=20
> Why should we excuse bad user behaviour? For things like long running =
jobs
> users have to be educated that their credentials must stay valid for =
the duration
> of their usage.
>=20
> Why should we excuse poor application behaviour that doesn't close =
files? But in
> a way we do, the OS will make sure that the file is closed when the =
application
> exists without explicitly closing the file. So I'm curious how do you =
get in a state
> with zombie?

Don't automatically assume this is bad application behavior, though it =
may be behavior we don't all like, sometimes it may be for a reason. =
Applications may be keeping a file open to protect the file (works best =
when share deny modes are available, i.e. most likely a Windows client). =
Also, won't an executable be kept open for the lifetime of the process, =
especially if the executable is large enough that it will be paged =
in/out from the file? This assures the same executable is available for =
the lifetime of the process even if deleted and replaced with a new =
version.

Now whether this kind of activity is desirable via NFS may be another =
question...

Frank


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945EF57CE20
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiGUOuP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 10:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiGUOuN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 10:50:13 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4690EBE1C
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 07:50:11 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26LEo7Pb016253
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 10:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658415008; bh=2DFWmKbaF3IAEMNq25CZyZuLRIOK5fudRQlGXkaKtvU=;
        h=Date:From:To:Subject;
        b=Kw2KIGjxI+E0a3dzPJhHcSrLcO5QeTsSEENdd8mTRSDLBTQ5T0YPESiB1wkA36y6O
         0q6Cm4gD3nY8btH6htfDeqmVoSuOf4TO5dQp0teBf4y8gW+LV0TvoueMlvcS9Z5W8N
         7STazohWPBpbLC/dg/N3SsdFQ9tmj39qHuJGkIxMMsAGLsfpoLv1sIGuRvXERit8Ms
         y6qxp9D7GwLtu9mchZmoxGgNYBuKxrLetgc0QapulDkplw4WcCvLEtjVh9RyTIR2/T
         uCR6zu0mqLOxcZV6s7wvk4zYz29G0c71bve2F3cDWp2gSJOZl29UNvWnZrOffdQDk/
         +/O8tTCfUQf6A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 67C8615C3EBF; Thu, 21 Jul 2022 10:50:07 -0400 (EDT)
Date:   Thu, 21 Jul 2022 10:50:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-nfs@vger.kernel.org
Subject: [Bug Report] Re: [PATCH v1] generic/476: requires 27GB scratch size
Message-ID: <Ytlnn6myHtOphb52@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ECUleclDvPCbIoQl"
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--ECUleclDvPCbIoQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FYI, modern kernels (anything newer than 5.10 LTS, up to and excluding
bleeding-edge mainline kernels) are looping forever in a livelock or
deadlock when running generic/476 on NFS, both in a loopback and
external export configuration.  This *may* be an ENOSPC related issue.

See the referenced discussion on fstests@vger.kernel.org for more
details.

	 			     	      - Ted


--ECUleclDvPCbIoQl
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <tytso@mit.edu>
Envelope-to: mit@thunk.org
Delivery-date: Thu, 21 Jul 2022 14:04:07 +0000
Received: from exchange-forwarding-1.mit.edu ([18.9.21.21])
	by imap.thunk.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <tytso@mit.edu>)
	id 1oEWma-0005LH-KF
	for mit@thunk.org; Thu, 21 Jul 2022 14:04:06 +0000
Received: from mailhub-dmz-1.mit.edu (MAILHUB-DMZ-1.MIT.EDU [18.9.21.41])
        by exchange-forwarding-1.mit.edu (8.14.7/8.12.4) with ESMTP id 26LE41LF006178
        for <tytso@EXCHANGE-FORWARDING.MIT.EDU>; Thu, 21 Jul 2022 10:04:03 -0400
Received: from mailhub-dmz-1.mit.edu (mailhub-dmz-1.mit.edu [127.0.0.1])
	by mailhub-dmz-1.mit.edu (8.14.7/8.9.2) with ESMTP id 26LE41L9023080
	for <tytso@exchange-forwarding.mit.edu>; Thu, 21 Jul 2022 10:04:03 -0400
Received: (from mdefang@localhost)
	by mailhub-dmz-1.mit.edu (8.14.7/8.13.8/Submit) id 26LE40dV023071
	for tytso@exchange-forwarding.mit.edu; Thu, 21 Jul 2022 10:04:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by MAILHUB-DMZ-1.MIT.EDU (envelope-sender <tytso@mit.edu>) (MIMEDefang) with ESMTP id 26LE3xuU023064
	for <tytso@mit.edu>; Thu, 21 Jul 2022 10:04:00 -0400
Received: from DM6PR06CA0075.namprd06.prod.outlook.com (2603:10b6:5:336::8) by
 MW4PR01MB6420.prod.exchangelabs.com (2603:10b6:303:70::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.15; Thu, 21 Jul 2022 14:03:58 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::b2) by DM6PR06CA0075.outlook.office365.com
 (2603:10b6:5:336::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Thu, 21 Jul 2022 14:03:58 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; dkim=fail (signature did not verify)
 header.d=mit.edu;dmarc=pass action=none header.from=mit.edu;compauth=pass
 reason=100
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu; pr=C
Received: from outgoing.mit.edu (18.9.28.11) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:03:56 +0000
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26LE3j2g024589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Jul 2022 10:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1658412227; bh=uMmUgra8WLeMLmpjopdjolODosinUcUJ8tJZoEfKN0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CWbvGQfur22W6jbvwyMRo9r/8MOsNIVQud3GtyJDewdmhD7/qXHos7RmtQpZ0Q0Y2
	 GzoXgRSs5XmCIJhpGoeCGOMYmY7FzraM0b97XEXC6hlwPzckvO2toM6BX6mqbvvwaQ
	 tgze+/Z9HrwzYFHZ28UBNClRXwpgrp3k1sdTBpPAhS/jlPpySD3WSCQxjBo25VG9ri
	 TXcalRs/X3W522fv3JSlXFmFClnV9KZw2jJxP49Ev3oe/QTjCvtAj1M7waykC+hydP
	 b/izLbtjD7vbtpHY2o2grcFGCMz9/myGOsazU6TXybEdPFVMU75zlajjYpXuDJTadF
	 lS20X1TO4H8EQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CDAFD15C3EBF; Thu, 21 Jul 2022 10:03:45 -0400 (EDT)
Date: Thu, 21 Jul 2022 10:03:45 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Boyang Xue <bxue@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Message-ID: <YtlcwZ/66pJhpdiS@mit.edu>
References: <20220721022959.4189726-1-bxue@redhat.com>
 <YtjYxyhVmSPzzFoH@magnolia>
 <CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com>
 <Ytk7t0am8H4x2BbS@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytk7t0am8H4x2BbS@mit.edu>
X-EOPAttributedMessage: 0
X-EOPTenantAttributedMessage: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b:0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af767f91-6ebf-42b7-17a6-08da6b21daa0
X-MS-TrafficTypeDiagnostic: MW4PR01MB6420:EE_
X-MS-Exchange-AtpMessageProperties: SA
X-MIT-ForwardedCount: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mjYpFeEZOdSfmq8cxwD6vllUAX3LFXnFNSV1645k1/U7ESDzdf/4bPwIJWX3?=
 =?us-ascii?Q?F5h9N9rl4zsvSkFP7vVuN0WTc/tAsgYpSlBgi8g3OYMxiq5kH38IAlBVWmw4?=
 =?us-ascii?Q?7wfXp7d+4h2PpwvAb4ebhv00dkV1LUyyjo0zW6GZW93VC2RwEO/iXuRVBdAo?=
 =?us-ascii?Q?WBVUtVseYieMdvsoB/kogAo3brM0MzNzdwiDDq6Qci+JKfX8Cnk52PxoW7Nl?=
 =?us-ascii?Q?aZb39FkDkM1OG64kUEd6b9f1Fx9EDKCZkSt1reXrH0ib7o7Y0bGETZJWozG9?=
 =?us-ascii?Q?KIAAOB4FFLjt85nng52MztDwLNyPh6rjFvNA4vwxy6lcbgHEyMuwPXK9fdSK?=
 =?us-ascii?Q?SrP6d6PX4Wva/A1L/QkRc5DpAKZWcmw9LrqvbXQ+FAgi42vwS7L54HdejgVw?=
 =?us-ascii?Q?GoLVmm/CN9K+TlJlW5jENiUuN8huQnJoezwJS8me3e1hEQbvisvetvMG1vOd?=
 =?us-ascii?Q?v7xLAcZLM3NZdF3gSM+XfL/X8RzVW9jJH0LXmQBVF8cr188vDe5WvpXPbsB9?=
 =?us-ascii?Q?AEy//5uwFg685Uvp0oZrstMsxnB+O2T/1ZI0iacrRdPhQbrHW2tsmABQXd2t?=
 =?us-ascii?Q?KdHDr1d1vcGi4XDSmkCQLfIfJnZyHvQlZLMBKJNT7wCCb+NYWNj5+PpBv527?=
 =?us-ascii?Q?zdwsqQv1ZkjcZmV8DMtCXPk8dlINud1R8I74/M5QGJMXR/WC+T1ys8LyGD48?=
 =?us-ascii?Q?w/cQAAgu8PtfDx/eMsUxPsP79q6S5qA8fn2jXoeRpeavHNWKtK/6JI1WkPqw?=
 =?us-ascii?Q?gqaaPicg3ounb0HRsh8nk1wE/l6bg+oD5e7Hwq5USCOmi5ApIUSt2tFqjmNU?=
 =?us-ascii?Q?nRn0RVmgHkAk77GVxjA3cir+Ckv4ZAcL2hpiYZZyNNBX+B+Y2t4uq9a5g3T/?=
 =?us-ascii?Q?yINduzJKPVOGZocQXPvK/nNYxMGnWIrTDIWX/d/OZP1+b2hQaYV6RddVxKxH?=
 =?us-ascii?Q?GN2XStHOWeKz+lBjZNCfRFtJ0aIr5jQxr62VSve1Uy9WEaqGiy9VwgK4XirX?=
 =?us-ascii?Q?moLOO7KAc1+OHvE6NVMm0pj+FwiV8dl/jg4GkeHVdHrnaCmmeHu2/fixnEyO?=
 =?us-ascii?Q?MUIwpLNPzNLp/jUSbnXvsCTr2JyNuVGkmCdGU+70Ky3jchX6AcGgmzRmSr7z?=
 =?us-ascii?Q?3p6mt2RGKhhRxEBQ0qW084tyyh3Yz61xrh/pqKdynmX534gB/rY0ZxJ2Oni5?=
 =?us-ascii?Q?Yu8MGlZKPlYQ1zri?=
X-Forefront-Antispam-Report: 
	CIP:18.9.28.11;CTRY:US;LANG:en;SCL:-1;SRV:;IPV:CAL;SFV:SKN;H:outgoing.mit.edu;PTR:outgoing-auth-1.mit.edu;CAT:NONE;SFS:;DIR:INB;
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:03:56.9708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af767f91-6ebf-42b7-17a6-08da6b21daa0
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-AuthSource: 
	DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6420
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 18.9.28.11
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-AuthSource: 
	DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossPremises-AuthAs: Anonymous
X-MS-Exchange-CrossPremises-SCL: -1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: MW4PR01MB6420.prod.exchangelabs.com
X-SA-Exim-Connect-IP: 18.9.21.21
X-SA-Exim-Mail-From: tytso@mit.edu
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: No (on imap.thunk.org); Unknown failure

Following up, using NFS loopback with a 5GB scratch device on a Google
Compute Engine VM, generic/476 passes using a 4.14 LTS, 4.19 LTS, and
5.4 LTS kernel.  So this looks like it's a regression which is in 5.10
LTS and newer kernels, and so instead of patching it out of the test,
I think the right thing to do is to add it to a kernel
version-specific exclude file and then filing a bug with the NFS
folks.

KERNEL:    kernel 4.14.284-xfstests #8 SMP Tue Jul 5 08:21:37 EDT 2022 x86_64
CMDLINE:   -c nfs/default generic/476
CPUS:      2
MEM:       7680

nfs/loopback: 1 tests, 597 seconds
  generic/476  Pass     595s
Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 595s

---
KERNEL:    kernel 4.19.248-xfstests #4 SMP Sat Jun 25 10:43:45 EDT 2022 x86_64
CMDLINE:   -c nfs/default generic/476
CPUS:      2
MEM:       7680

nfs/loopback: 1 tests, 407 seconds
  generic/476  Pass     407s
Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 407s

----
KERNEL:    kernel 5.4.199-xfstests #21 SMP Sun Jul 3 12:15:15 EDT 2022 x86_64
CMDLINE:   -c nfs/default generic/476
CPUS:      2
MEM:       7680

nfs/loopback: 1 tests, 404 seconds
  generic/476  Pass     404s
Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 404s


See below for what I'm checking into xfstests-bld for
{kvm,gce}-xfstests.  I don't believe we should be changing xfstests's
generic/476, since it *does* pass with a smaller scratch device on
older kernels, and presumably, RHEL customers would be cranky if this
issue resulted in their production systems to lock up, and so it
should be considered a kernel bug as opposed to a test bug.

						- Ted


commit 4a33b6721d5db9c07f295a10a8ad65d2a0021406
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Jul 21 09:54:50 2022 -0400

    test-appliance: add an nfs test exclusions for kernels newer than 5.4
    
    This is apparently an NFS bug which is visible in 5.10 LTS and newer
    kernels, and likely appeared sometime after 5.4.  Since it causes the
    test VM to spin forever (or at least for days), let's exclude it for
    now.
    
    Link: https://lore.kernel.org/all/CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com/
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/test-appliance/files/root/fs/nfs/exclude b/test-appliance/files/root/fs/nfs/exclude
index 184750fb..ef4b19bc 100644
--- a/test-appliance/files/root/fs/nfs/exclude
+++ b/test-appliance/files/root/fs/nfs/exclude
@@ -10,3 +10,14 @@ generic/477
 // failing in the expected output of the linux-nfs Wiki page.  So we'll
 // suppress this failure for now.
 generic/294
+
+#if LINUX_VERSION_CODE > KERNEL_VERSION(5,4,0)
+// There appears to be a regression that shows up sometime after 5.4.
+// LTS kernels for 4.14, 4.19, and 5.4 will terminate successfully,
+// but newer kernels will spin forever in some kind of deadlock or livelock
+// This apparently does not happen if the scratch device is > 27GB, so it
+// may be some kind of ENOSPC-related bug.
+// For more information see the e-mail thread starting at:
+// https://lore.kernel.org/r/CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com/
+generic/476
+#endif

--ECUleclDvPCbIoQl--

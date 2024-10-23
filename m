Return-Path: <linux-nfs+bounces-7397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F19AD4E8
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 21:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E451C22844
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E0C1D0DE8;
	Wed, 23 Oct 2024 19:35:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta05-relay.cloud.vadesecure.com (mta05-relay.cloud.vadesecure.com [195.154.80.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679F21A0AF0
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.80.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712110; cv=none; b=bzosoDHhZjpRRhhNULe3zcwVAiH8ki1ml3VUGwrLMnNkZYzXshasoHoP0cXfWx7pqwDTGFjhqjLODqKOKbyIz0WyMic3etCd/jag5Beeqw2voOgaXo5CyX0N9zzHur+wvAxAMLyBfKKD10iR5YvIMHH/uSK375Si6G+mRyjP3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712110; c=relaxed/simple;
	bh=PmOx2SWjqSDS1bz1BfwQht7iZ+KTwqYPVOQ2phD6K7Y=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=FHA2KGl5h14rHfw2EGoV0I4b8bfEt382d2Z0Lkvgl4f4dF/gPGpnCE5teTMqT45ByMdeypiD4HBTo2yqf5lM7zyF3T3V7ZhzLceOXaRZajauzXUrwktFX4zIRBLAYRyV8d1YBBkp6Xsh7vyd1XnCjqs+dnbEDaIbVjfmBb1G/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu; spf=pass smtp.mailfrom=minesparis.psl.eu; arc=none smtp.client-ip=195.154.80.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minesparis.psl.eu
Received: from smtp-out-1.mines-paristech.fr (smtp-out-1.mines-paristech.fr [77.158.173.156])
	by mta05-relay.cloud.vadesecure.com (vceu3mtao01p) with ESMTP id 4XYfFf5WXJz7VF0
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 21:27:34 +0200 (CEST)
Received: from z-smtp.mines-paristech.fr (z-smtp.mines-paristech.fr [77.158.173.137])
	by smtp-out-1.mines-paristech.fr (Postfix) with ESMTP id 7DB04C16AA
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 21:27:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id 778E61C00AE
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 21:27:34 +0200 (CEST)
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id q3fPhsrfvskt for <linux-nfs@vger.kernel.org>;
	Wed, 23 Oct 2024 21:27:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id 4DE081C00FA
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 21:27:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 z-smtp.mines-paristech.fr 4DE081C00FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=minesparis.psl.eu;
	s=9f5ccecf-24a0-4eb3-a015-b6ac3b07c299; t=1729711652;
	bh=PmOx2SWjqSDS1bz1BfwQht7iZ+KTwqYPVOQ2phD6K7Y=;
	h=Message-ID:From:To:Date:MIME-Version;
	b=s2bcrCH833wfnLDCzmQGYtjt/WbHPJqctZ9NYkSe/DNX8F/WjIibIgbQk6/xxetVu
	 5aocSQ7oAtlfXeIlUTe2ayRNLx4siudGcB8BM8iC/TJ8xeCYbkU9fRvdnlD5c6TFs0
	 qmks+FF2VSESSxqfogHkFXpllNZkszu3MadvLUQ0daPgW40cATMiLQexrltiCaWhIC
	 jUUjpMysNw6Qevx887Lof8Kg4TvePhcxU30mmb5hQXSpTFohTwHjfOD3yYjd/WUbsX
	 6yhpZUxGjysS71YB2FlgIP8K1DdCZiLEzTuFSNIkHnh7QjuXPtAPG1V+w++LsKRk1z
	 BXDo+Vl2Buf6Q==
X-Virus-Scanned: amavisd-new at z-smtp.mines-paristech.fr
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dNwXofdpCXgM for <linux-nfs@vger.kernel.org>;
	Wed, 23 Oct 2024 21:27:30 +0200 (CEST)
Received: from hive.interne.mines-paristech.fr (nat2-sop.mines-paristech.fr [77.158.181.2])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTPSA id 761781C00AE
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 21:27:27 +0200 (CEST)
Message-ID: <1cbdfe5e604d1e39a12bc5cca098684500f6a509.camel@minesparis.psl.eu>
Subject: nfsd stuck in D (disk sleep) state
From: =?ISO-8859-1?Q?Beno=EEt?= Gschwind <benoit.gschwind@minesparis.psl.eu>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date: Wed, 23 Oct 2024 21:27:27 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-VRC-SPAM-STATUS: 0,-100,gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgudefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfevpdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvffftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeuvghnohpfthcuifhstghhfihinhguuceosggvnhhoihhtrdhgshgthhifihhnugesmhhinhgvshhprghrihhsrdhpshhlrdgvuheqnecuggftrfgrthhtvghrnheptefhveeviefggffhuedtvdegieffvdehgffhgedvhefftdfgheduueevtdehuedvnecukfhppeejjedrudehkedrudejfedrudehiedpjeejrdduheekrddukedurddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdpmhgrgihmshhgshhiiigvpedutdegkeehjeeipdhinhgvthepjeejrdduheekrddujeefrdduheeipdhhvghlohepshhmthhpqdhouhhtqddurdhmihhnvghsqdhprghrihhsthgvtghhrdhfrhdpmhgrihhlfhhrohhmpegsvghnohhithdrghhstghhfihinhgusehmihhnvghsphgrrhhishdrphhslhdrvghupdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0

Hello,

I have a nfs server using debian 11 (Linux hostname 6.1.0-25-amd64 #1
SMP PREEMPT_DYNAMIC Debian 6.1.106-3 (2024-08-26) x86_64 GNU/Linux)

In some heavy workload some nfsd goes in D state and seems to never
leave this state. I did a python script to monitor how long a process
stay in particular state and I use it to monitor nfsd state. I get the
following result :

[...]
 178056 I (idle) 0:25:24.475 [nfsd]
 178057 I (idle) 0:25:24.475 [nfsd]
 178058 I (idle) 0:25:24.475 [nfsd]
 178059 I (idle) 0:25:24.475 [nfsd]
 178060 I (idle) 0:25:24.475 [nfsd]
 178061 I (idle) 0:25:24.475 [nfsd]
 178062 I (idle) 0:24:15.638 [nfsd]
 178063 I (idle) 0:24:13.488 [nfsd]
 178064 I (idle) 0:24:13.488 [nfsd]
 178065 I (idle) 0:00:00.000 [nfsd]
 178066 I (idle) 0:00:00.000 [nfsd]
 178067 I (idle) 0:00:00.000 [nfsd]
 178068 I (idle) 0:00:00.000 [nfsd]
 178069 S (sleeping) 0:00:02.147 [nfsd]
 178070 S (sleeping) 0:00:02.147 [nfsd]
 178071 S (sleeping) 0:00:02.147 [nfsd]
 178072 S (sleeping) 0:00:02.147 [nfsd]
 178073 S (sleeping) 0:00:02.147 [nfsd]
 178074 D (disk sleep) 1:29:25.809 [nfsd]
 178075 S (sleeping) 0:00:02.147 [nfsd]
 178076 S (sleeping) 0:00:02.147 [nfsd]
 178077 S (sleeping) 0:00:02.147 [nfsd]
 178078 S (sleeping) 0:00:02.147 [nfsd]
 178079 S (sleeping) 0:00:02.147 [nfsd]
 178080 D (disk sleep) 1:29:25.809 [nfsd]
 178081 D (disk sleep) 1:29:25.809 [nfsd]
 178082 D (disk sleep) 0:28:04.444 [nfsd]

All process not shown are in idle state. Columns are the following:
PID, state, state name, amoung of time the state did not changed and
the process was not interrupted, and /proc/PID/status Name entry.

As you can read some nfsd process are in disk sleep state since more
than 1 hour, but looking at the disk activity, there is almost no I/O.

I tried to restart nfs-server but I get the following error from the
kernel:

oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104 when se=
nding 20 bytes - shutting down socket
oct. 23 12:00:10 hostname kernel: rpc-srv/tcp: nfsd: got error -32 when sen=
ding 20 bytes - shutting down socket
oct. 23 12:00:10 hostname kernel: rpc-srv/tcp: nfsd: got error -32 when sen=
ding 20 bytes - shutting down socket

The only way to recover seems to reboot the kernel. I guess because the
kernel force the reboot after a given timeout.

My setup involve in order :
 - scsi driver
 - mdraid on top of scsi (raid6)
 - btrfs ontop of mdraid
 - nfsd ontop of btrfs


The setup is not very fast as expected, but it seems that in some
situation nfsd never leave the disk sleep state. the exports options
are: gss/krb5i(rw,sync,no_wdelay,no_subtree_check,fsid=3DXXXXX). The
situation is not commun but it's always happen at some point. For
instance in the case I report here, my server booted the 2024-10-01 and
was stuck about the 2024-10-23. I did reduced by a large amount the
frequency of issue by using no_wdelay (I did thought that I did solved
the issue when I started to use this option).

My guess is hadware bug, scsi bug, btrfs bug or nfsd bug ?

Any clue on this topic or any advice is wellcome.

Best regards.






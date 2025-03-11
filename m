Return-Path: <linux-nfs+bounces-10550-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E2A5B5C7
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Mar 2025 02:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA13818946BD
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Mar 2025 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B91E2845;
	Tue, 11 Mar 2025 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wi0Fzjmm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4191E1A17;
	Tue, 11 Mar 2025 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656031; cv=none; b=g9SwXb2/5lyzImvQrj9zzvD8fj6N/nj7b9XxiZZK1MEsW3lwAJd8RIEsZp2JXNDzPa7bgYKpvsqZxVXr1ZBuiZ5Pgm2FkshyWG63x0Q2t2RfoweO1Os/RmiymdvbHAGUPiVoqAaRLIBTCktSKPNjY6ztjUCntOrlRr0bxUFqoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656031; c=relaxed/simple;
	bh=34R4iBMYkNwIZW2c4Jm/VrAGEpij9SqFvkCLwnE1iQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJpi+HRh0pBUdpcmwquXhvW9zy08e7osvlUqAfZ7dt0oPcqT/bmM4NKpu5J1Ky72yuNpyb5v+csXR3zm0TvMP325wwDH0bjnXHxQTfs6QKgA+36dJ+vyZZvgjKGzocDx5FdfWBoL1Lnq8YvuJL0ObHt+nA9vyDL/pTSYfdzjHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wi0Fzjmm; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ALgTYm017881;
	Tue, 11 Mar 2025 01:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=O1l3Q6hdDfVpSHm5BOkDpAGIeyKt2R2zixyQs3hB5Xw=; b=
	Wi0Fzjmmpmi5HDDQeQkraouJn6JosnFRFlmZMzfJmL2AI9gjmleP/5IikaO7TOgM
	f/SVeMEzQK+G2nFx7pIXEYphRaa8d6oM8qbnnVGofEk1YvBUY+lUX5PqATiOx7lq
	mGr1vwKw09o0tD/qRJOng8PU+ujEpQnc0zT8pBOj9++ma+594zpI4VQglIvI/NMy
	fa7gJQkiT+rkLWaiq9R5nrQiU9VaO5YR1607ayBA9eNMAlRXf1y1kvONWbxCY6EL
	hUSSj23TGJ3sNgNEtGi3nnfo746rHNoE5rpH16MWrz2J9Q3jN55R5JQSvLcFuaqU
	ujkwmu7Y6IfeBRn8/1C7ww==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cp33vvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 01:19:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52B09KML014954;
	Tue, 11 Mar 2025 01:19:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbencnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 01:19:46 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52B1JfrJ014960;
	Tue, 11 Mar 2025 01:19:46 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 458cbencm8-7;
	Tue, 11 Mar 2025 01:19:45 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-nfs@vger.kernel.org, nicolas.bouchinet@clip-os.org
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
        Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Joel Granados <joel.granados@kernel.org>
Subject: Re: (subset) [PATCH v2 0/6] Fixes multiple sysctl bound checks
Date: Mon, 10 Mar 2025 21:19:06 -0400
Message-ID: <174165505001.528513.14421854436163772182.b4-ty@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110007
X-Proofpoint-GUID: dLkaRhK_qqdeCFBaLV_uVw2BUsIaNlNk
X-Proofpoint-ORIG-GUID: dLkaRhK_qqdeCFBaLV_uVw2BUsIaNlNk

On Mon, 24 Feb 2025 10:58:15 +0100, nicolas.bouchinet@clip-os.org wrote:

> This patchset adds some bound checks to sysctls to avoid negative
> value writes.
> 
> The patched sysctls were storing the result of the proc_dointvec
> proc_handler into an unsigned int data. proc_dointvec being able to
> parse negative value, and it return value being a signed int, this could
> lead to undefined behaviors.
> This has led to kernel crash in the past as described in commit
> 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> 
> [...]

Applied to 6.15/scsi-queue, thanks!

[4/6] sysctl: Fixes scsi_logging_level bounds
      https://git.kernel.org/mkp/scsi/c/2cef5b4472c6

-- 
Martin K. Petersen	Oracle Linux Engineering


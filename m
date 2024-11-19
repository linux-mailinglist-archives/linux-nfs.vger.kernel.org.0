Return-Path: <linux-nfs+bounces-8126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5609D2EC4
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 20:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E14A1F23B38
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 19:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD951487E5;
	Tue, 19 Nov 2024 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eyeVHz6m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B0MquGFb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6D843179
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044099; cv=fail; b=oC58NXFnJ5U58wpdAPDn8rLLOFqF9B8LEpDmaKkfZydeAMQQGaLu1FJOc2NbsmO1UPzi8Dz0PABN8yCqsTCzwmuziGpEVtDZD+tJh5jGM80gAhNSct2/2CFh7YWgX9lvwKQVWpTTMileGLvI2nrl1vWxTDNacYXhogqvpw8hQIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044099; c=relaxed/simple;
	bh=VwfOWZ0MymVN0uUYMcvrPyXRPn/2a9RvsIOHTerQp3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nUCwNFXdTk5TSy5o5K51fBQ5ZcGf+t8T0g1XMFBn/SxORv6vK+t13KW+biglWhY1iZQYJ2xbH6nM+QUeb02d8FGvlIF6mwlKYHha+LVga60vAPH+ovSXBupmIzvPa3N4REBI98Yb+fN+i2J9/HiPYzhTdAXG77IvSq6yMmS+J+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eyeVHz6m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B0MquGFb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIMgRE027817;
	Tue, 19 Nov 2024 19:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=SKsJ1V1A2CnShDC/v2
	nHAmEf52aNtctcaksZUceHhuQ=; b=eyeVHz6mTQ9lzWnfmKyWQJ7C492yZebvC/
	EYzSBunRhb5hRJPg7c5mwOdWQpNanLot767sekOJ/VchmonE4+2QsmcEJziBWeMM
	H+IuYbffi4t4KT+YNnvr5GP4ihwBYRmuvoK9PoalfYs9hwajf+BWCmtjl4M6yYKJ
	5zVPMmd2DyaYF7wbHxZhGw2ujIyhdW012/yhq2w8LklzCh5RKVk7XmGx8hHbrZ+k
	5eUc7kCEeTYPPEndeiU4cu23dLDhhnoogDWdhSxxYbaQie+iiuJoV7erF998GCGB
	46Kog+ewnFuGzWg2jb6jHh6ecAyJWXV6rPQbbCIvEEmfWGiUXv1A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebwuwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 19:21:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJJ2hCb007832;
	Tue, 19 Nov 2024 19:21:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu90sre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 19:21:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDJT83pdntdb+UP8EKB2aRYe12R05L6fBVvXRJWnpDkK2bcxBcZpvImVOJNV6E8z5gWFBKIOD13MUFq6UniyRX8EQ5x2kl7mjmxLxU4RAGhom62AYa4uMhwui3neImcGoEHA1N3gB5YldGiNjZPWhYRmOpQGK3WajcMIqsmb06hsxUyx9QoyyuarbRoE7mQLnzZRSoW+SXRAj2ewIbPBoiLcqgN6Fi8sAqPN+VFfJpReEl+B8aY8pOM/7qRdouRZVLvk/7UMidlq2QxRDk7zWb4k0Whbh65h4B5IAGAL9lSYNZKn8dy8EHrx5GOFhGXbkSCQHSUB5vhpoJMJUTBwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKsJ1V1A2CnShDC/v2nHAmEf52aNtctcaksZUceHhuQ=;
 b=xu9rJF0L6a9KqdLR8oJeCHeBmxTHOx+xaulZTCl2cBvGVAIQnlyuLdJIBL2P5cwm2X4CodHJ0ErKfhCx+7oqk16cbYShrTZT+zseFrL39L6WP/B1SXX7/xMmBVz/hTfk8JxVCmXNtC5teheeco/JSkzhXc3h3xvvnf5+d+lZpfUaMzj8IZKv1RhO9C8T+ALB0wj38sT0cRggc2Huyy83vx6uhEoodN82Mpojq6JwZwwzSSY6yIXcsqzLyKL9VlUDCx0781T1GhFALAhPCpK80b/pekdEpNq11KRAGwKbsjf1w82mLBePrsnmOyBdwixmxZU3pmTMDSyz8319/he/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKsJ1V1A2CnShDC/v2nHAmEf52aNtctcaksZUceHhuQ=;
 b=B0MquGFbdAbmVdi4Zm7mbGYBOfA+RpPL7/AiEkOVYow1dcX22gucznnIB4vKL1c5pgr9/AFki6hbCDCEiUtz5CWxsmvb6Ej9oWQ6OLMnm+WPIleli9JuGTSVyt7xih7T+koWx8CVu1AEbXdEra/9okstoR1Gb0gIDKJhLNVEV8U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4278.namprd10.prod.outlook.com (2603:10b6:610:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 19:21:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 19:21:24 +0000
Date: Tue, 19 Nov 2024 14:21:21 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/6] nfsd: add session slot count to
 /proc/fs/nfsd/clients/*/info
Message-ID: <ZzzlMXO1mteXdtWj@tissot.1015granger.net>
References: <20241119004928.3245873-1-neilb@suse.de>
 <20241119004928.3245873-4-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119004928.3245873-4-neilb@suse.de>
X-ClientProxiedBy: CH0PR03CA0429.namprd03.prod.outlook.com
 (2603:10b6:610:10e::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7dc5ff-3509-4266-2bd6-08dd08cf5ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XVB9VqPtSU0oS5vFiG+Wii7DKOWDiMcQwb/5ow0aiW3dIoVpz/CzYq6DumDT?=
 =?us-ascii?Q?Kxu2IxDKgFPuYMn5vESDJL2MPjkzNJZuJ0FMDphyF2+uXww+dtZDv0hraHXw?=
 =?us-ascii?Q?qRvkzaxmauRchb01QLFOAP0vSR33nJIQpbs5+39mZJt0BTBNLkNhPab0ISAx?=
 =?us-ascii?Q?Rcz98P5kjDblzXvblH/38yZ6QLZl7FmkYq+0hGXqdjCffN5+zF2tbcKKmnY3?=
 =?us-ascii?Q?yUfYUVlAOAHSfbCIpIbYKgEwi147TysKXFP5FqNhUfGwvpwQgmImbLmlXut3?=
 =?us-ascii?Q?XNdzBq+VGlua/lmSlII32OBaa+rKzSf/9WYUtPbalrMIvlbgX8VgrQnV58ul?=
 =?us-ascii?Q?3mh32SsKK/3pAdQej1LO0k1c8Q+/Jpj+90Xp54m7prS/elNb7D3oppYTuMRW?=
 =?us-ascii?Q?UaTv7MY3yjciJUirtmvhobRGsLjavVNtawrAwy0bm8nZw6ZziSPILxj3n2nE?=
 =?us-ascii?Q?v8RpYP44Hfy14+kTy28U5qP1F/oLyiXdu7pvZwEj27cG6AHnM2wv8LjexSmq?=
 =?us-ascii?Q?hyIipk89DPdkIH7iInTs+bQUBOtV4Rv3zHNsesOTAN6cB9yb/sV4LpkklU4Y?=
 =?us-ascii?Q?MPGDusbReEgH28fnZEb1xMz2G0I9vnks/FTKKxYLyuKH0tGqKP0gqW6l4J3W?=
 =?us-ascii?Q?uY63wpDYCll5OCJE2xnqam/wNx6dQvejMDbLEpNAkaXeoHMEdnlAubasUKsT?=
 =?us-ascii?Q?R5YnnBiZOaJrdXoCUdRGGbnfgHi9QqMd5hg2BiMzE+u+5auvn+VDldRepmvH?=
 =?us-ascii?Q?UKwn+xTG1tM3LSVUbgJOIppq6dtW/3jv+f3qq/97kjD53oKJlLT5sl+PMU7E?=
 =?us-ascii?Q?XC/o0/KmjFmycTkgr7fdrI/h/+L7pF1CILrJnWGYwZPvLNbuuOY3zKvr+d14?=
 =?us-ascii?Q?4DpS9RqHaqf8LA5CjDdB5H7ebH4tJ5cE5IM4oV8U6tWCbqTwdQ7DihnkRb7T?=
 =?us-ascii?Q?nyZpvH+sEC5pKzMoQ9r4G7La2hyx4Psu8de1hQZ/qVGbXxpnT9sqlSDiR+Am?=
 =?us-ascii?Q?oIcYkl5FoLOdhHcLuMxaMozqiZZ6gz6RWdHrAWssijVvRdBQn+3IKmukOiru?=
 =?us-ascii?Q?/9SzylyBCf+19g1LTYvEkO7ubu8U+P1Ii8aLMad7PAB5UOsuXk12cDseausD?=
 =?us-ascii?Q?7d2nc57PWmlCjkYVIaMNjxMKby9Yq9MXcZ5jMd8jIQQhWRVmUuw1hJ2lpJ2/?=
 =?us-ascii?Q?s3CMEGgVLReG28AJ1L99Hk1lwvzKcP4rqv0J55RSn46OWeKNXWv/zTdQyLXt?=
 =?us-ascii?Q?3ZgE3O2+gaSDY3R/iClWneTnTacZZNeuOh5IlSyN/PHg3+8YUZeKJqD6A7ef?=
 =?us-ascii?Q?LyP8S2iWWcOIvVdJD3ZpwbvQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UBjZYwv3nxS0Ab5HxbAUKq1JvS9zBmEK94UC45PmEaWj/dU8Mch98GpHGRb4?=
 =?us-ascii?Q?uUjCPrc0BdknViih5IPr/8T+NQe7cQbneL5GCBB+2b7NmUzvzrgjiY9J3AN7?=
 =?us-ascii?Q?mkVP0RkEeA5zvLjqcTi50+7r6wNm3WT2wsIq+kldhUOeHIXs3moqwCMowQl5?=
 =?us-ascii?Q?P0hoZm1thX9/MHKgR+otEl+oBQTi8pAJGbk1Y+9+j0c96btxVRCE14tD9008?=
 =?us-ascii?Q?lhl6djwJU3kgdM5HDcGiDuQ4XBZ2wZNOl+NPcb6QeA5VjIA2u3tX6JmAEveu?=
 =?us-ascii?Q?l7DtmKS88ZnY0uobJKI24gsYCzKzk2xPeaxlkFXvAvDM/UExBoIXFbEWadxa?=
 =?us-ascii?Q?NBMKjY8Jc6mbvhgON3PO8W3v8igNJt+h5+vcnmc56C6NK9tHpoMmHrg7LQ0C?=
 =?us-ascii?Q?st4+G64hrmUG2UmIUlvNOnu11gQy2YPl/CSk9YQYKrn4ULpCXE31vRHXGq/6?=
 =?us-ascii?Q?7yz7z87KgrXsFBo1qRqv6eSaV2D6cbqA5wp+q0bGEfwQKN3B6mlxjS9UzVEo?=
 =?us-ascii?Q?Oi4SZ9jMnc45fXtcGxOVcXSnffp8HLql+AsaaEDZKTSB9qCHWqRtDiK2W+AC?=
 =?us-ascii?Q?PJRDF+C42oTUnXS1X8ZIxrhkkJ/osGkzYkRB4dek10NJTzj6tFef01G/EIuv?=
 =?us-ascii?Q?8tfJnx3eBCNlYOqT+EGbGabaxo2S1oZRbqfmFQtnO37/w3mGpB6fAHAB4g+/?=
 =?us-ascii?Q?W5CCrzzMG+37hQfIBsw97x3pjBSTeOcJuLHg5vBVDozV7O1OwSNIf7BTCg2U?=
 =?us-ascii?Q?H04rlOzLmRVyEfZ8wVRlYv9bzxvi8FoGBYBijHMtZNM7MTTi0jjE+dJiirc3?=
 =?us-ascii?Q?18SlG9PpfTZMBbHruqFULOqbTPyVIGdktkpMzRoCgHnt6SAgvfzxlnCOwRQ/?=
 =?us-ascii?Q?7bEUtTegkss47qmiSjA69WBXy3171TINaC/ITXE4lhJUIjEWAEXx/DncDtdI?=
 =?us-ascii?Q?yZEIl6AKvU5yweVScUs92Jt2FLvIKllyleJZBoJt8J7GZCBm+l1Z04fl3msb?=
 =?us-ascii?Q?8oIbdv+bG2NO80BlrSsOGlUkuqp9oSAtepOu9C+DB/eHKtMOzBTmYAbsojBt?=
 =?us-ascii?Q?FwDUtAQE14fzvIufWYE5kRYGKKRa8uis18ZXoAGcMqnVv0QF9HJez6EELZ5v?=
 =?us-ascii?Q?bkIWgALtZb/uaP/F0YTpdqnQqIFPYLfkA5PycfKsetuAtrBDyIJ0Qm/qz6PI?=
 =?us-ascii?Q?5Zcj7k1qt/4YszxTdAUDTB0PSONrIoVZLzvPjmbd5o1qMBh1AQ1zTGVM5vfn?=
 =?us-ascii?Q?GOBuaq0//mAxpGs4ZpJzQP8C3BEe22IkIhLm85V8haXIpEOscKizl1efGiKy?=
 =?us-ascii?Q?RqUNwEC2xCUkFMVGD7fFAW9bpdUyhIsIdCcTXekN+ynyRPxx3LXRdqgvM+HH?=
 =?us-ascii?Q?DOKRfIk0LFg9Qz/Dt//GnNzk7DO7tMEkGFRCcqN33/6dGp7EPWX0OCf5LkUJ?=
 =?us-ascii?Q?JJ3HNWCuU2jLmddK62kx1cs20zdF7uus2c1HVd1Ltw/W3NruycEibCUbGBCU?=
 =?us-ascii?Q?D3h/z2ElgWT9mUXVUJGJzoJMAvEDDOviePunmwvH2ZmyFeg1G6xfXw3p5/4O?=
 =?us-ascii?Q?Y7jthrudUunuzulcgaYBFpFaqrdZfIkTetcwi1SMlqmHpiF1WOfhrRrSMtQP?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kPbHQb2jv2keyDW1xiV/tjVEbV9HLUT0dr/n67hqcHdkjzOX7bdyMNWF40w96CWCISjqj9YaOJg82WKB/YPsEUoAAQ6jHFe7rXR7q3MF6UVApKBAs6iM0qa+ESkrQ6qudnJcCyQXI7nymjZLHo9suvZLaaH6I6GUN946egXrkn4wU7k+n5e0yd0/hdaPlXq3xfHzSvnbscwvE6VuH6mIu6+OTxN3wbRDnV+NdT91TRIKScS6BOaDTNarWnTrv5iaiQcNmv8zA6/TusdN83vLY88kaqiu+YF3i5BqFsrY6clAHaEI4OyyaUEwg6baBihxqBApCENFROKqgctta7XBqqEYYLuv1V0a6NGFDx25YwXtNSJdzoovfPjcfB0euvVR5N6w3nA0THWDbyO1C3JC5QT8jGMiKaXuuGsnSesn7HGcKdjvmK6JCfIqyueFI7c//AR9KMekeEhMSVRVsmyQdy0rSdwoFa7kLcWJ30rZ70o2QilApEyOjRXcM6GjweelzOanngEDrybyYGEnY0MLaAXf91iTtyyG9eDMtq6alogHecGm+hZL63ikLT80rqI0MKJz5EyHHnp4xvLdnbJo29W6EmrfJ7QktQGhKu4q8ho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7dc5ff-3509-4266-2bd6-08dd08cf5ba9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:21:24.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMgC5OjBLcEpR8WW8iQbwrHPZZEqv94nL/PMg9WFH6wdNMowmivL1CIg5SYkzSrGVypMwK0222YAvXYNDQ/ViA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_10,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190144
X-Proofpoint-GUID: wkEfuCqTI8wyCBOCJHswvRAwZKMWz-fG
X-Proofpoint-ORIG-GUID: wkEfuCqTI8wyCBOCJHswvRAwZKMWz-fG

On Tue, Nov 19, 2024 at 11:41:30AM +1100, NeilBrown wrote:
> Each client now reports the number of slots allocated in each session.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3889ba1c653f..31ff9f92a895 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2642,6 +2642,7 @@ static const char *cb_state2str(int state)
>  static int client_info_show(struct seq_file *m, void *v)
>  {
>  	struct inode *inode = file_inode(m->file);
> +	struct nfsd4_session *ses;
>  	struct nfs4_client *clp;
>  	u64 clid;
>  
> @@ -2678,6 +2679,13 @@ static int client_info_show(struct seq_file *m, void *v)
>  	seq_printf(m, "callback address: \"%pISpc\"\n", &clp->cl_cb_conn.cb_addr);
>  	seq_printf(m, "admin-revoked states: %d\n",
>  		   atomic_read(&clp->cl_admin_revoked));
> +	seq_printf(m, "session slots:");
> +	spin_lock(&clp->cl_lock);
> +	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
> +		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
> +	spin_unlock(&clp->cl_lock);
> +	seq_puts(m, "\n");
> +

Also, I wonder if information about the backchannel session can be
surfaced in this way?


>  	drop_client(clp);
>  
>  	return 0;
> -- 
> 2.47.0
> 

-- 
Chuck Lever


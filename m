Return-Path: <linux-nfs+bounces-8124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4A59D2EC7
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 20:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C26C4B27F68
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE54D1448DC;
	Tue, 19 Nov 2024 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LsVQAPLy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pdAs4WQt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2041487C5
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043678; cv=fail; b=mQheAI2UuyoK1e6lZekaE0rhj5skVTa0SWCR0QSEv62l5S2vNI8/dBWuQoGXNO3X7FwBRq0IZBRb9LJw57/uOEH++uMjKw+sk0dGMWeIzAa9nk8GWnbVxBmPLQbmddQzHjMGQXLi6/8uaO30QgXSuU7dPYxkM6hKou687Cqpw4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043678; c=relaxed/simple;
	bh=pu3oUQOCOnglxNAGt2DVwwu2Z1DNOkgF+2bxXDFaRiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tUShKD6hkw1DaU4WI5pIwEBXhzwY3YXy1o9ZygPx9WqTsZb5Fq3kCRgXlhX+fQr197TjSMT0nccxIc+IpVgFa702H/9ywUowYUr891F79eDZFbVvZztB8A7hbTXCzJ6uKPXGd3/yZJQEz2qoxnUTfz83yT2glJh+YQb/X4FaXhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LsVQAPLy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pdAs4WQt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIMZIf018861;
	Tue, 19 Nov 2024 19:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IQ2GEqUWWhsff4Leo1
	RJ7iV6VIdkYuSnyF0iskZW44E=; b=LsVQAPLyW3Pf+nb9qR96HgB8DZkFS3In83
	huNORA8s+iFi/ZHB5Z5yTSMCqc7agroouT89A3FV21+qbW91x2YrOM+zUB8NqDnt
	ogSX7uWSNEHcATajVKquCZCaYWqOeBpdHRtOazBdfz1IqImUsOKUhRJAdNd/8bPe
	pJcX4chM0g8ZrXLnxeqrmRwx4YtbtBYdaLUrC1f6xoO8fQKiTtH01Lu5XsnDqc5U
	hnOiaYGKyom2ezdxXIy19eQvQY836O+Vm9hgRgP8F83jSw/gOCVudliNLKaki/rI
	aPlcnXHrlIlK6ab+HCpnFkzuwsW11X9QmgnpD0aDl9Gxi/xi/evg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc5te4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 19:14:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIFD7P008575;
	Tue, 19 Nov 2024 19:14:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu90h7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 19:14:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDy9d0j4yJ1J/8y2CcZ+lz0U6q5/BvhhzQR+7VUseCZ3hCc1bDn4PpBTvkb3Ih3Wg6EFvi5ARQ/OTDIxfBb2F4lVPnU3xyu4JJIsukKXbt6YnovpQr9B+YITfc7UDsvXAdPWPl+8bk+OuwmgGWOYs9iGHzd4oF2nMVebDbkJVfOZcua5MBWxbDgXvkArNuMBzy2wNOOpxhyaVSTxPTl2Dc8gvKdFE68f9nwkIjcdIT/EDuWSfNstsIR81OHI3sDl7SplEVfDPBBRk5lYuA4EeCpLBBAEEBvQpgtBmJIDguuSn7JFaXEEnYmBRl0E0jnGm99HOYZ0PFo/IJvmLvCTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ2GEqUWWhsff4Leo1RJ7iV6VIdkYuSnyF0iskZW44E=;
 b=l8zQJwtRx3pf5C5wPTnTtbe8M11dAl8YyZeVLgHbxHvvrZQ6ywYufKxqsanT2JwdCqq/C5gxWCuu+uOS2aqOwBDvJ0SskP3sTZSOyq+de+xwp5TKTGHVV1R+8w87C9fVxNK2aDEaAQt/RC6wMtq+8ULukgAdW5lcSmEzL+6XqafNv247k8uKinDkldI8PHn6KhO9msQ5YaJyDM1wD20YHtjgc3F5PI54+Tq+bIpN0veAedtUEhJvtBhj0IN9OAeJmvaj7Co46ks0UgPY7+KxgWaH8cEoEGj5ghj4gKNi4G4YjRkW+FC9lOCaz8bU1EiC20F6dKiOg/oFvcDnSV6ONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQ2GEqUWWhsff4Leo1RJ7iV6VIdkYuSnyF0iskZW44E=;
 b=pdAs4WQtlqkytEWCOdJRrTUFiFnbmODmR07Z0yrjnx04uvDIqkuz8tTySez/IX94iP0uxd07NhweqxwVXz4bNqgeJlTt4zZ0D01shCDEfObGB3WVcGaCqHP1ipzG7pIAAzX8caBhfZTZopwzaDW0vBbCaGqKI0vZP3IPcMRIkKo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7208.namprd10.prod.outlook.com (2603:10b6:208:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 19:14:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 19:14:20 +0000
Date: Tue, 19 Nov 2024 14:14:22 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/6] nfsd: add session slot count to
 /proc/fs/nfsd/clients/*/info
Message-ID: <Zzzjjln34sdtnEkI@tissot.1015granger.net>
References: <20241119004928.3245873-1-neilb@suse.de>
 <20241119004928.3245873-4-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119004928.3245873-4-neilb@suse.de>
X-ClientProxiedBy: CH2PR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:610:60::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 63590b22-d196-4cd3-c5b9-08dd08ce5ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qWvZoyS/cF+CnIFFRlyKOYH370O94AyJ3KGBdbHBjSA+lM0RRv5eh8oSyb/H?=
 =?us-ascii?Q?Ak4jYKgGoTc2vSGOMvW7qipWHklMCZD8kFL4vJDnho5lcYpzK9QA6NJzLXAZ?=
 =?us-ascii?Q?WERgox1A2GSRDZyFwngRa/iPfSDfCwSoJ8hZ15SpddaoODjZ3kmvUqEKwhx5?=
 =?us-ascii?Q?RGRHKi/367lpq5/gRkSUDaFDD8FHMqKMLU6z6IkMusu1hZC7xxurWZ3JiwEJ?=
 =?us-ascii?Q?wKZOHK4zpv6SL6zqmaGR9xWWSaehAXTTZqnvyZTE5GuV7Afkgni+dOLGmox3?=
 =?us-ascii?Q?k9FdqxSrRgIqvckVqRrfFe3hYrJYGZ+KPdh2FkNtTaRYDSoZjDCABqUp6o6c?=
 =?us-ascii?Q?z1IUtrsEdPWfJhR8CgMznxC/WvMlNj8NT4f2vP7J8ZqXdg250/br59HpfNm4?=
 =?us-ascii?Q?mI63JcFBGB1InkYW4QAU4Jp8pDR3632V/ZqzKimo+gYblyeZAmgRNa6Q1qxG?=
 =?us-ascii?Q?dA6bTUQhx5UhOHGst8P35KrqOmFojb7jakF0rmejf3O4qm6nJhQjoiZeS0sm?=
 =?us-ascii?Q?X7gJhlPDQrqdHyscaguvW6GXp/uwrNovSvh3Ckufgc2bZNPPXb9pWEIj6QJz?=
 =?us-ascii?Q?P4SIIpz8ROB4t6ox7GwcNFWMo4UpAs7YpXhg8gLqpPyfC/nIH6odSt8pGdnc?=
 =?us-ascii?Q?4R8rZ0z1NvLFh028F6LRsFzqzzGVWw7Rl9L3bqp8/6UoDIntuJajuEIOGQcu?=
 =?us-ascii?Q?QZkDPiijLVWWKKmyreg6OOm6YPnSiIsw71K9wvRFVE/B2LFzoAnbIESF+h5h?=
 =?us-ascii?Q?1FB6QgZizy7vJAj8EkdY12d0t1+uKuRSXEKgdhh3ZW2X0cK2IcmpwyUKoLlc?=
 =?us-ascii?Q?XT7/lOurfz6xOP1w2CXAoHef3s72qRIUVy7tKj1jqItVRPpe5eg7NlfoM9Hk?=
 =?us-ascii?Q?n9FEu/M6fbAaeUg31+0/U1Z6WD2Jg2NNjU9JhCJiQggYjk3dentjNFvceq2j?=
 =?us-ascii?Q?pIbfyMMXwPv8H2r6tptbvfTSvEOI1SmNut+NWdgNV2ITtokFq+kDuUjIw2Cy?=
 =?us-ascii?Q?r4bfEKObC8FUh6ABDGLZbE9VMA/Tp/KCAkSISSEZEPsvnYQieTqi7HvwRCmE?=
 =?us-ascii?Q?CIMoD4LZw9pQBM2q8wYXdKj5N2WvEHrR70RF2VbteGk2J/iBpcQmBp1OCVqP?=
 =?us-ascii?Q?72duKwbH3+M1QzkehodR2zS6qz3yrdcilVS9AO7WNAAFgon2VNqHTnEFl9Cs?=
 =?us-ascii?Q?XMXGwvC/t8R+GllCbGeg2DfYhXIuBL+uRrTEpy5YqnZZBN7RhD4iPYS6iGq/?=
 =?us-ascii?Q?tSvkuQO1Pte6mFJiAluYYEf5BOam2/LWQcOZZl5dcq8WC4wlWJvhyqCG7a9n?=
 =?us-ascii?Q?nvbZsMLZz83eGaGk9qEXLDee?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IxFVGoOdVN3jlCVSpJrfgvxOSHHLedLbQKpFH0Wj5fA/HJZHp4p1MaymYM+9?=
 =?us-ascii?Q?Bq66DdTyMTCjvMM+jFDDyUnnaDGnth16M4blqoCLX0k/gGPk1LucJzVgpEzO?=
 =?us-ascii?Q?/DlOAp1pAulAJkZuFdrVyYLyo9GHh0wohez0CFw7IdwrGAYmROGtoFyLae+B?=
 =?us-ascii?Q?LU3N/R/iHqNXGTM0Q5K0HUFu74cPhs0DBR7pkQXDPzx45yT85umvVFN5rpr9?=
 =?us-ascii?Q?/3XYn+GLPJr+1f1eA4O0iekRJ9X+8KZF4J0UJiDPkL8y0Qe0LwGBhITuCMX/?=
 =?us-ascii?Q?Eo0IVFbLkKnpPzFa5YQnjm23u9qhx+yAOmbGbM5PCE2EX5tq7txVgUb+6TPw?=
 =?us-ascii?Q?u2dRwjtbGZbrmUQu5poXo7z4hJnbJcnnMrFs5qMXpzwkkdSpnLJctFw6VLOz?=
 =?us-ascii?Q?nN+iWlRv1emcgE9cntYh5+P+vJ1Jwco9R9S/RCDw5cd4qvtUOEcYvCI6f5BJ?=
 =?us-ascii?Q?ptP61vYvVxVKB+G6+BU6YrVEglFNADFiCuk9p+N/2zRjLnuzoqV1xjAbaY7G?=
 =?us-ascii?Q?EvA7n3zPrtuRNbSC2U1Hkk6bnCugIallQpOMnRKsy4dVXo+sRJvtrEIz5D1B?=
 =?us-ascii?Q?kmNGyZBw67gLY0u/zcLGJkGiCCMhKZ86TPNhKXsMKRcEpMOfqHjtgiNYCqJl?=
 =?us-ascii?Q?abS6/IGG3SDtQg1mfZt4gh9HKoX8qazYsgS/h78hJkt4oJAvWGgP8tmHoR95?=
 =?us-ascii?Q?9UnM5izJlJvJfSBmU4/RLn61D/ceZBRvavWUkaEkVMeKQGbWptYPnfNBPIab?=
 =?us-ascii?Q?GOOQEHOFsSYKbX7+ND3wFsA4ACrEIejhS8sNwXzxZGF02TSMfu71EzS/gO4i?=
 =?us-ascii?Q?Rxx69vQpeqIOKt+/Z0SX7pXHqd7D3bWS9pjLwtZnS0l2t5kYBIivTPWlnU/8?=
 =?us-ascii?Q?fP5WMWnbwgrYITtAz5f6swaRSIoRU7tky3PzJ0BnUfpKLNpH39AlGqqpuOzC?=
 =?us-ascii?Q?y0d+6cFkrI5CFikr9XxwoE7NN+6mgtdxcPazwlgW6gq+B8lLS8rQETpu7FTf?=
 =?us-ascii?Q?A77Q4EODErXaKTvb9MZVfW8UUJfXLUHV23PR3yvDZbazxFJFbWzeCFfUVDCP?=
 =?us-ascii?Q?xBQ0pEJsxwV1NPMqz0nHdKDz3/SjDH3HTlcRy/uFwPNTSPGNF98YrWgTn/r1?=
 =?us-ascii?Q?OiHVnC6DE5aapOCsg9NAO40rvbqttRGtg2V/RrQ/2GiI00ecD2EN1j+y8rGN?=
 =?us-ascii?Q?Z2jKF68gkpS8pS/p2pv6LiH5FlgvRnvZlezjPLYrL0BAlMLIHrwLAvFZrTzs?=
 =?us-ascii?Q?GdBJlKy1aJPf8J5hmB4ulISPGJ0ru9tz2rU9UuaF7HJvRby9pk6JI7J9jMOI?=
 =?us-ascii?Q?6yqdntRLJutiRs8ShfiwStTRvo3jbZj+QDbfZtlJR6reHpttALTXathOPMoR?=
 =?us-ascii?Q?3WfYAXX7Rfn17tO5yBl3/y2Ik7klSpTe6qsWgcmPh3yzDMcHp21s3Pul/xzE?=
 =?us-ascii?Q?pheLqK0KgvXA4is//BMfUMmrUa3GpdlDwGEhafnChUHV33WMRXrVqkw93rPf?=
 =?us-ascii?Q?F8hgCVk6rpsWi6ckgZZ7tSq/9IWNq0d0mkY0BPgX7jN1xMUNDVxrTLvq2d8o?=
 =?us-ascii?Q?/KSPygPYD/A3QWb5BCojqqtlZ7mMaK+cT8UvfKXcb+fbfMTQUnlOuj9a20eg?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FAz+aruqpe8ftnHfBgdzxIN9EUhKNpZCKUPPDIKnlyxgHy0dQg1L+W+dM4i7w4CuGrEAewLJzgyaWvD58dJxnkVYM1ozk/I054cW5rFsvbaA5e+U2wclZpEZZL+2NH4RCziDS31+TRUKZwfl4LWts3NF/AZY0o7X/5Q2CRDuo+ZCCEZaYwGvP4MYBfL8URQIIvpVkYHdcGrKwYJY5eY2yDC51NPXUc5+xHQ07EbLHzrpFvhfWrAjEqlGNUeyiu3ck+wipSGh/rJq73dVleu12sUMuWS+2lBGs6GOLAyh8Hfe9ZObpnUDXcpDykjE6x3veAieWrEwgSddQLEhm8+Ing2paWzkOgS3cHAnEua1bh0cTR9Siqo0zAhMxzIGzj8rNWmODeAB7uTCbguOvlxEhDx/weNdPuK8hs2OATzdgKm5RwpufiTcl4Gxr/6BeYX+rSdhlLPyMRPVnXwCqTr9UdJKIG337dV3RXOhMnGkUKpSEp3q/zo0qkPSJUCqmHGp/0+ROCSWXzMmSb4tJuJE3BKtmnfXQp5WlL1EquWrelQM7ly+++9SpoqJVA1rgg+3a3HayWJDgwXg7cbnbGE0j+3P8kfejt1PiumTcKwsyGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63590b22-d196-4cd3-c5b9-08dd08ce5ee8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:14:20.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlSuHJmv/ab15ir7ATJR7abvN27KiffPw6djycrybTf1eGVS2wyGwxt9Ppff9rEcwEWOkeXY3dcMIjg+Q5YDoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_10,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190143
X-Proofpoint-GUID: hy3d9znhMCm1tOl2Ci-f67yXEIJKzNPR
X-Proofpoint-ORIG-GUID: hy3d9znhMCm1tOl2Ci-f67yXEIJKzNPR

On Tue, Nov 19, 2024 at 11:41:30AM +1100, NeilBrown wrote:
> Each client now reports the number of slots allocated in each session.

Can this file also report the target slot count? Ie, is the server
matching the client's requested slot count, or is it over or under
by some number?

Would it be useful for a server tester or administrator to poke a
target slot count value into this file and watch the machinery
adjust?


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
>  	drop_client(clp);
>  
>  	return 0;
> -- 
> 2.47.0
> 

-- 
Chuck Lever


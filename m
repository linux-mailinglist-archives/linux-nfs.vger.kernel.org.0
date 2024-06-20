Return-Path: <linux-nfs+bounces-4152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0BE910882
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189E51F2286F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBF81AE862;
	Thu, 20 Jun 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D/I84i3j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m6TGnhFT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B41AC425
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894067; cv=fail; b=ZBcyxlaK6+0YP2zTp7AcZbo39qjCt3exroA18oWUoCHGOhP1fWytXsAX/ZA/ok20jGv2HzOaYG6W4OApsPIcBbCZEL5XAt49tdocBc6u7xH2CstuHY5WmoE32W/k7rmQeqjHG88HFmcB0VBACpcT3wrFveSiAQ7f+Zb2oJZ2Iao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894067; c=relaxed/simple;
	bh=SQat5DQWxYkNwjx6gd3qMeOsJIqVf3YNYdFTkIxlUZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TFkhqtGVKaawBejJ2qmYiMeEIUu5lNpuK3DPB31GeWCebyQtzgonPWlFI/GdFgzi3qNP7uwukNWV95vVau6qaAIakZyB/5995X4qzVBihKe40GMrI5kdUB74DHYgTus92e9Kya47LZ5P2LkanKZLAKo0NPyxGXMPZnSsP1YKUOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D/I84i3j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m6TGnhFT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KEMUhx002226;
	Thu, 20 Jun 2024 14:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Ybom8bC2/CMXtOC
	EFQQp2tJcCjifwhn28hFS+mfwjQA=; b=D/I84i3jUDxaAByYhz1GUMsR1eIA+17
	duw61UuQY7EJ3wnfTSxPc7340QXqNMT794eDqFMDGHZIigTXStbJR39FoqF5YVG1
	QRhbV3SGOXgDBZHZfEQQbSV/qzRrFRgXiUs0GRPRNgdXSgZbyVsVdfbOjG0Hh3vt
	fQlb1/CdoZJrpxp4Ky6V/N32FQFpnLi6ojW4iza6r+YY2mQ7PzDBeIkiGmMA4BQz
	37S56ZbSKVQDDkc84xKBF8SLJSwYWT5kJzYD0hWLSsfRQhdOc0SgL+0Ymt70fMPI
	P1zWBcmYC6ZjUgUnUB1g39cuu+M6l5qdd4imkNVowRFKfxlIjdh0E5Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuja0kch4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:34:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KDQ3gg034772;
	Thu, 20 Jun 2024 14:34:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1datcdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:34:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaXOnsaJLLru5bq6W9h2hvuWfaiEfvDVOsf0OZgpKrAtXGSQGl9stnNdo9PtSIZQFViaPht9CpI1Tlx9WY1uJUGF0DVlLycyfY9AopfqlrgcNq9JwAUXW6psfnE7PqnnyhXd6Uab7V6BEEcJtyTNpUrLYFCEOuvCSSm9L2Y7IVKeRfTZ8vAocXq8sr2iClf9dgSJJnB+ldjao7dLa3Wm+42AhawIOh3kTlY9hJlCg2FJJT5sYwqGUVnsiXuGgcUi9n7YA/fpuGEpADpOOe+OI+s/nHaWMAZW9Y/D4S7/3rfJMGjbzLF0r7tGEaZ9KAoe8jSj6rjhWZz88eAgHMhoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybom8bC2/CMXtOCEFQQp2tJcCjifwhn28hFS+mfwjQA=;
 b=fXxJ1SkcCYQrIn+B42M7M3E3F+TudZpv9lWpfxN13JwNTwn9albnNC68A6GPm/QwCh9bEwyTaqj9M5LDJgPA7fJQUFnDfnhZJ5DtPFVSusZGwdT13dEoZb2kX3ofI4n+mRQ5Ui1NGQ62q9WI0Dy+4/qscDCJDXrrIvaDcLUzAyYeKcPKToOcYw6+6Ul6WA2Chmht0Cfu218GPVhcTkOomiOZdmF7JJLSvs/qz4kJOUINnp+c7QqN1r4XeFKzXy06Rj2TB8oNTnL9mOidZEZepQtssQgr38TEKgT1AoKc9oty6aBSo9m+MoUc1xey5v1vA8zgRFvw0ejegBCbl5akuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybom8bC2/CMXtOCEFQQp2tJcCjifwhn28hFS+mfwjQA=;
 b=m6TGnhFTpjZBv4yxCBKUYJkcqEECjg261xGJcMmSfYqzEEwP+HwugGCbA4RWeG1Tb31Xb8Z7j5afxzAz1cw5d42meDHpeVFkHIt+M4jXzP7HIiHhGJ0psVjMxKnMluXDwGquEU9Dbr+jon4vfzQbaU8plVa7FSwXRsJGsA+tSqU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 14:34:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 14:34:08 +0000
Date: Thu, 20 Jun 2024 10:34:03 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <ZnQ927sF7oRT+KmF@tissot.1015granger.net>
References: <20240619173929.177818-6-cel@kernel.org>
 <20240619173929.177818-9-cel@kernel.org>
 <D3359408-4D02-415A-9557-19A6EFE5DDCE@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3359408-4D02-415A-9557-19A6EFE5DDCE@redhat.com>
X-ClientProxiedBy: CH2PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:610:50::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 16dc3a1e-9e28-47e5-a6f3-08dc91360b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EQDE5VS4EJN+K9mXILUK/iJBVaZ8UDSuf2aob0BXkSOCy/BvwaZMyVVXlwU5?=
 =?us-ascii?Q?ClZXJX9xsHS/hEGu+MIEA81lmuVW3TAUqG05xbMtKY0tchPz4ocpMWeKBaqi?=
 =?us-ascii?Q?r+IrRlH39qreqlVBHOXYkA43BEaFPmi7gou/YuJGKtgJ/KMHyN02d0sG+P7z?=
 =?us-ascii?Q?JOklxEcVGvFNdSd59jLyfzMKdDNjTQ/Ji5yiew++b7S/4Vnh2m7l9wordk+Q?=
 =?us-ascii?Q?6Y5n8iyBwIl1ojMwF+TT4x5dlNbLBn5w5gZFa5LoScpqfLYJvxMFSGrPr3ZD?=
 =?us-ascii?Q?W2CC9/nmjATCDKzh9zREDBCjYzPLRF9VebOrXILBbWYukd4JRqK/zsvw+2ns?=
 =?us-ascii?Q?HVjFeD7cbo5mmsaN3ZBYPsY1Sl1OytoTGhajpggc85/5DYGXLov7Xfv9Uh2O?=
 =?us-ascii?Q?eys3FbqnlsPh8t0NwxOWY+Q4wyVrHir/c9948wBEZZWbeHucLxwYArdQKR2G?=
 =?us-ascii?Q?tE8JIjIz17gRzKJX41Wuh7zl8dbdblVrlXm7vvuvSmJLTKYfh8UVXmoYIANz?=
 =?us-ascii?Q?bZFikZqCOZ7Ie/xbiZfN67HFw/xIIYcZ36kLLiTEMd+St5wFV4kL12fMhxzS?=
 =?us-ascii?Q?ydq8c981hmiB5G8UkQO1kk+f1dF0jiGcoUJIuTUqP1nSQt7z8esNNbidS9fP?=
 =?us-ascii?Q?DCbTZ80ccXYjq2kQU7rxDlaMSwzFRtSyg+5lKPeTkzv9Rlgsh8SBxFyjQ0fG?=
 =?us-ascii?Q?iRzXPA5jauZneEMYTj5hduaCmraZlKD8XDzevM9vW1KgEDH0GyNN3wr7hUib?=
 =?us-ascii?Q?W8hRJsLtPJo44htvzoYzM1FE46Wp9bKJUntJuVZM0k9NJENfcZA9YySY4M7z?=
 =?us-ascii?Q?3CerOt/iF36Xr3e1XWRlYSvMuncV6PXXipmt/3SHE3yDG+IN32GjcVznb4Yw?=
 =?us-ascii?Q?s6b0BBY61D2uw/dHzWOyzxFd4HrFjssnnHVJUgj8DXdZjZpMNZpwWAapDrxJ?=
 =?us-ascii?Q?XUFxEydmeafJbdYwBKqA6xdgL81hp816bTo+sXaSMs4MG7qjBc2F5CWrFCbU?=
 =?us-ascii?Q?1jUZROfY0WlWNpmOWfcLGSAE+s7JvNeNCkkRxgJ5cKmtiFUeRVPhWVcYqSHc?=
 =?us-ascii?Q?NGslKl/NsaDddm6+jcvLRTiGHnQ8xULY4oVmvXqEIiZBskGSdxpIEXnE3Tqo?=
 =?us-ascii?Q?BEUGuCsB/0hJa6D7b3U2zSBsrR9FolQJ2tVT+6OV6NWTAOmGewzqeC0K2zOg?=
 =?us-ascii?Q?XQJvrKpgx/o5WmCyL2pPusjVl11CdeNC4Amnv4Remndlh0fCtgaaZXMsXFdu?=
 =?us-ascii?Q?kPWsGNuiOr8GwbCTaDKzpheuT8pzsM3qbcz17hCJNZtZ9SfWPU9YXgFASneZ?=
 =?us-ascii?Q?XFrNJG3fqbQ/eD1KYFbQZHPS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g45m5p9nSBgZC8sdLoRQRGYuBTCf8mARyuUxlUJTJ4eyjzBaH/x/Xc+Fl61B?=
 =?us-ascii?Q?Gb0DKauzXsa8V6pD4K7qe6qGzJFbr8i8HzY4DGu+614uKYr4Ir7ZnAWbSSSw?=
 =?us-ascii?Q?fvq8tc5W3mVNIptth/+tHj3z7mgZy6UEHM2AyZ4RDEvpGUBikSOC8Okt1SD/?=
 =?us-ascii?Q?6AU2Gtz8bqxedQpcpQlmlFvgB4HnVr7Nnw01Q/29Og5E6g2pE5ffe3wJs8AG?=
 =?us-ascii?Q?gjpoMUW3cyeFFFnZugx8rs+80A+xpKNtn5mYHFlWJ785sIFtNFg6Rsq6tFX4?=
 =?us-ascii?Q?NgnAQ0ZBpDkNW08kL5KfhlX9ZtMigmrfO4CWF7Y3ak41FrCP3+2NmqfyrpoL?=
 =?us-ascii?Q?oINUVNIcFEAmykB2dlLOy+5D44d0SP65WhQY1Boa7VyBQegAmNx2C+3EKTaB?=
 =?us-ascii?Q?3dFpePCV497+1GDwLKiYh685RqmuI/3aBlNmdn3WmBzOBfwdKAjaZfSG92tt?=
 =?us-ascii?Q?qlR/M+0sigo3A25ile3ZGK3Ok3+nqgYlOsHBIDPTkIiWpHF+lgtBc08ba9Yc?=
 =?us-ascii?Q?Eu56mxXfUN3ULHTooWnBujXDnsBNBk1RK97BTGU8jlOJLowtKfeYJhTeVRGy?=
 =?us-ascii?Q?T0SgDo5EnPxi4yHNAdPjGP/PyFWmnfi4pY3MKgoiPWrbAygxzppkNwvzYbxS?=
 =?us-ascii?Q?bHCVul4Hz9nhwB30xYQo+1rREmM4hBHFKvawGfvqlkDnZ/UycM55c7n3OpyE?=
 =?us-ascii?Q?ILp+JG08i4oJWlYFdzIOZ/SvNjRxLXuNCzXK9SnwBd7WjPaKuCDp11gdnHAO?=
 =?us-ascii?Q?DpMSLbZP2I1WxE4PTJ76awNSmT/nB2JdhyMmgqXMRlS7b6ikHXyDAIkL+58E?=
 =?us-ascii?Q?uokmZ7FgM9fjPpiIdH31i268Ary2PJPYoURn7dGBeKe/G+QiUUltzOBcY0fE?=
 =?us-ascii?Q?yQYZJOfrrZerkJhYblMLxw+M/ugBpYjj+jUGNfs0uAk+ZBzyN8oS0jvDqHhV?=
 =?us-ascii?Q?aZrTkU/aSBfTbUCeqY/lbaHsQaxE01BuQwhLHH89z/CU1/Au7BPE1BXWvUS1?=
 =?us-ascii?Q?QKythrq59z0VhFRgb5otniCRH6mTyQu9iCIuFzPIhLLRS4KmLESeS68thWHh?=
 =?us-ascii?Q?iKVS+FCgTGMagGrZui408jDH1xYtOLaQkn3sWP5Q8mnpL5szFMoQlQe7x15W?=
 =?us-ascii?Q?XATpqMp3eSCRKR6U68j0RY8o/kKaPm2d48oI3ndDL5l0jN2fgULmpYdjALNr?=
 =?us-ascii?Q?NesStQ8kW4T7vko+5TXE6YIV6WZjObADuxzSSfPcQHrEepBbOM7HPrecDdOh?=
 =?us-ascii?Q?VJpDK9J35MT07MkRbFF5wsF0MQGT6YpmYgUzxgyGhzF3NG6KMgW6Fmh0MiOs?=
 =?us-ascii?Q?HtnixgW9QJTtL8BUnJ4xH5ZrV5EsWblA/yS0+kn8PZcPCby5RJkNRq0gAC1V?=
 =?us-ascii?Q?bg/1osspU+N4bPbCW1X0AZLv8lPi+Z2Uq9AKey4bOrLOu94gQR9/gnKWZEla?=
 =?us-ascii?Q?aWOD0Z+uLzq1Ii0CUeVmhXL1zesybm+G2HlKyXRo+JsAEMqNC99jaloXvLI3?=
 =?us-ascii?Q?27mVGQX7Ilba1s0B22FRGnoRkrrZmcxAiLwRLJae6jeWMguGSrKlMbXbxeL9?=
 =?us-ascii?Q?qLFAp+25URoQCOOgS/lNGuCSfvJUEa6Pes2EMOEZTlQhnVgzV+FXU3MrNmik?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6lEmysQvKmGITEHx1RukNR6Y/bSZC3wGngGOBbMV6KM1udIJBhpOi9Kx0bFSuPIRB171NJKW6NcxPOQRnOHp1lNzNoGn8b21bf3lHlwT9DpM6LFfwhD5jWrWcJG8UShI+bEM1SK15eTJQYJ2Kv9VkTECZntV1OAQNW6OdtXYxqyqchRPrSR/NMuwntGv9A8novAl3s3PpVD220vbu7yPzhXpBE6AJIuUkVHVv9uBiH8lZDZlVH7561RTkEIZV1rGCfqVgfcrw7EC53rBIqJU19IWHbupn7n2k/Q+ODmj10OERjqGtKZIdvmYwrC4rRQKZSEnpeCaj2hWUyZrXwF7xuZ9qjTCT0NvQlQqdw/ZvZMWf5ffCKCGzlB3a0dw0lp2IhyJ2oVmAaG8aiPKkpA6rBQsC78wuYXzBWFYBc6z32O9+VocMEyf1VCoHOHlxIhmDlZ0gPLngBPBoojnavy1O0bErumQiF5rBHvWZlqEqiG/5E349OQU4Eq5aOUze2QD3z5f8uoBfTghSAzc+MvKG685HoIFX6dfTMVg2O0aZGaexHzfDhBnL75qo6k1J2hwdpk2T/SKIZ+9t9nYi75f1BiZoCn9S4ELJXUrRTg6m8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dc3a1e-9e28-47e5-a6f3-08dc91360b44
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:34:08.4837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATyjIuIDVBm7lSywtcyb0GSSa7vhqxf0AUubqkuo3LF3FW1+WQdT9cgTpny2ZGGm+0jdUbHpJTsWEz3JofT+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406200104
X-Proofpoint-ORIG-GUID: kjlPoVhrCArIKeN1C7RP5JiZoJ54cuWk
X-Proofpoint-GUID: kjlPoVhrCArIKeN1C7RP5JiZoJ54cuWk

On Thu, Jun 20, 2024 at 09:51:46AM -0400, Benjamin Coddington wrote:
> On 19 Jun 2024, at 13:39, cel@kernel.org wrote:
> 
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > During generic/069 runs with pNFS SCSI layouts, the NFS client emits
> > the following in the system journal:
> >
> > kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405e3366f045b7949eb8e4540b51 (-2)
> > kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
> > kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405e3366f045b7949eb8e4540b51 (-2)
> > kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
> > kernel: sd 6:0:0:1: reservation conflict
> > kernel: sd 6:0:0:1: [sdb] tag#16 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> > kernel: sd 6:0:0:1: [sdb] tag#16 CDB: Write(10) 2a 00 00 00 00 50 00 00 08 00
> > kernel: reservation conflict error, dev sdb, sector 80 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 2
> > kernel: sd 6:0:0:1: reservation conflict
> > kernel: sd 6:0:0:1: reservation conflict
> > kernel: sd 6:0:0:1: [sdb] tag#18 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> > kernel: sd 6:0:0:1: [sdb] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> > kernel: sd 6:0:0:1: [sdb] tag#18 CDB: Write(10) 2a 00 00 00 00 60 00 00 08 00
> > kernel: sd 6:0:0:1: [sdb] tag#17 CDB: Write(10) 2a 00 00 00 00 58 00 00 08 00
> > kernel: reservation conflict error, dev sdb, sector 96 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> > kernel: reservation conflict error, dev sdb, sector 88 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> > systemd[1]: fstests-generic-069.scope: Deactivated successfully.
> > systemd[1]: fstests-generic-069.scope: Consumed 5.092s CPU time.
> > systemd[1]: media-test.mount: Deactivated successfully.
> > systemd[1]: media-scratch.mount: Deactivated successfully.
> > kernel: sd 6:0:0:1: reservation conflict
> > kernel: failed to unregister PR key.
> >
> > This appears to be due to a race. bl_alloc_lseg() calls this:
> >
> > 561 static struct nfs4_deviceid_node *
> > 562 bl_find_get_deviceid(struct nfs_server *server,
> > 563                 const struct nfs4_deviceid *id, const struct cred *cred,
> > 564                 gfp_t gfp_mask)
> > 565 {
> > 566         struct nfs4_deviceid_node *node;
> > 567         unsigned long start, end;
> > 568
> > 569 retry:
> > 570         node = nfs4_find_get_deviceid(server, id, cred, gfp_mask);
> > 571         if (!node)
> > 572                 return ERR_PTR(-ENODEV);
> >
> > nfs4_find_get_deviceid() does a lookup without the spin lock first.
> > If it can't find a matching deviceid, it creates a new device_info
> > (which calls bl_alloc_deviceid_node, and that registers the device's
> > PR key).
> >
> > Then it takes the nfs4_deviceid_lock and looks up the deviceid again.
> > If it finds it this time, bl_find_get_deviceid() frees the spare
> > (new) device_info, which unregisters the PR key for the same device.
> >
> > Any subsequent I/O from this client on that device gets EBADE.
> >
> > The umount later unregisters the device's PR key again.
> >
> > To prevent this problem, register the PR key after the deviceid_node
> > lookup.
> 
> Hi Chuck - nice catch, but I'm not seeing how we don't have the same problem
> after this patch, instead it just seems like it moves the race.  What
> prevents another process waiting to take the nfs4_deviceid_lock from
> unregistering the same device?  I think we need another way to signal
> bl_free_device that we don't want to unregister for the case where the new
> device isn't added to nfs4_deviceid_cache.

That's a (related but) somewhat different issue. I haven't seen
that in practice so far.


> No good ideas yet - maybe we can use a flag set within the
> nfs4_deviceid_lock?

Well this smells like a use for a reference count on the block
device, but fs/nfs doesn't control the definition of that data
structure.


> Ben
> 
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfs/blocklayout/blocklayout.c |  9 ++++++++-
> >  fs/nfs/blocklayout/blocklayout.h |  1 +
> >  fs/nfs/blocklayout/dev.c         | 29 +++++++++++++++++++++--------
> >  3 files changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
> > index 6be13e0ec170..75cc5e50bd37 100644
> > --- a/fs/nfs/blocklayout/blocklayout.c
> > +++ b/fs/nfs/blocklayout/blocklayout.c
> > @@ -571,8 +571,14 @@ bl_find_get_deviceid(struct nfs_server *server,
> >  	if (!node)
> >  		return ERR_PTR(-ENODEV);
> >
> > -	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
> > +	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0) {
> > +		struct pnfs_block_dev *d =
> > +			container_of(node, struct pnfs_block_dev, node);
> > +		if (d->pr_reg)
> > +			if (d->pr_reg(d) < 0)
> > +				goto out_put;
> >  		return node;
> > +	}
> >
> >  	end = jiffies;
> >  	start = end - PNFS_DEVICE_RETRY_TIMEOUT;
> > @@ -581,6 +587,7 @@ bl_find_get_deviceid(struct nfs_server *server,
> >  		goto retry;
> >  	}
> >
> > +out_put:
> >  	nfs4_put_deviceid_node(node);
> >  	return ERR_PTR(-ENODEV);
> >  }
> > diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
> > index f1eeb4914199..8aabaf5218b8 100644
> > --- a/fs/nfs/blocklayout/blocklayout.h
> > +++ b/fs/nfs/blocklayout/blocklayout.h
> > @@ -116,6 +116,7 @@ struct pnfs_block_dev {
> >
> >  	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
> >  			struct pnfs_block_dev_map *map);
> > +	int (*pr_reg)(struct pnfs_block_dev *dev);
> >  };
> >
> >  /* sector_t fields are all in 512-byte sectors */
> > diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> > index 356bc967fb5d..3d2401820ef4 100644
> > --- a/fs/nfs/blocklayout/dev.c
> > +++ b/fs/nfs/blocklayout/dev.c
> > @@ -230,6 +230,26 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
> >  	return true;
> >  }
> >
> > +static int bl_register_scsi(struct pnfs_block_dev *d)
> > +{
> > +	struct block_device *bdev = file_bdev(d->bdev_file);
> > +	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
> > +	int error;
> > +
> > +	if (d->pr_registered)
> > +		return 0;
> > +
> > +	error = ops->pr_register(bdev, 0, d->pr_key, true);
> > +	if (error) {
> > +		trace_bl_pr_key_reg_err(bdev->bd_disk->disk_name, d->pr_key, error);
> > +		return -error;
> > +	}
> > +
> > +	trace_bl_pr_key_reg(bdev->bd_disk->disk_name, d->pr_key);
> > +	d->pr_registered = true;
> > +	return 0;
> > +}
> > +
> >  static int
> >  bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,
> >  		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask);
> > @@ -373,14 +393,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
> >  		goto out_blkdev_put;
> >  	}
> >
> > -	error = ops->pr_register(bdev, 0, d->pr_key, true);
> > -	if (error) {
> > -		trace_bl_pr_key_reg_err(bdev->bd_disk->disk_name, d->pr_key, error);
> > -		goto out_blkdev_put;
> > -	}
> > -	trace_bl_pr_key_reg(bdev->bd_disk->disk_name, d->pr_key);
> > -
> > -	d->pr_registered = true;
> > +	d->pr_reg = bl_register_scsi;
> >  	return 0;
> >
> >  out_blkdev_put:
> > -- 
> > 2.45.1
> 

-- 
Chuck Lever


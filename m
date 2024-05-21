Return-Path: <linux-nfs+bounces-3309-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F38CAFF8
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 16:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319261C2386D
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706EE7F466;
	Tue, 21 May 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XTaXatcu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D9D2nOCK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6A57F47B
	for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300205; cv=fail; b=Sl0hMcK1s4seXxXa+UpOCxyoPXfh0s+IFkThgn2PGObsn/b6VjTc/kK0TIvnCghPl2EuYV0gaC91H6pjZHmy4Y/6NxDi/IUa/GeLJKP6ah+RNGNbcnjs9bUcqi1moPasN0ZT4P3HBXFZ12Ju2KM4W8wFKXukp7VaG4rCuiY+VjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300205; c=relaxed/simple;
	bh=a7BD0dI6VtFWmCIU4IZ4DmHxWYSNSrYAZ5Chfp2ubCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RgKZMF1GK1P69tCvGeDe9c4iN1EO9OpiMg9Vu106ZZK9t9zKaYo/Ypk+Oaxs+ABAvWRY5ggP6FOclgZDoAjKp/AmnczIRZeqoU1rm86N3MJlh1HR5+KZXLSVLPJ27cR5LcQamym4M/oPzGcdBd2icm+DEYm43pu6onF0P/zGzh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XTaXatcu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D9D2nOCK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LCxxpk022689;
	Tue, 21 May 2024 14:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=IZEgsV97QtlWXMlEPberlB0hk1QvFTfLZwr60T6d/mE=;
 b=XTaXatcuqKtbB64WD+PqYevuIM2Bfw3haY0rTUJKyXEhz+HaHYnk76+f4aOcR0EL7JiY
 madpgqR0t0AGsIUrOHQDZv18YkpCw5oKf3asejLfVkTVFQPzNRrT8MXBWVoAKaJ+qzT8
 vwrOyd7z6spxhon8HmIU4aZro0cFqDwQkc/PSmd+ci/KwPk+N9m0glpNgl2RpeHzha+n
 KpN+rf9RegK4ctGUq7+3UPnZ3u/RWTvtRbYMsktR9UyxNSCDsAkbCDLcPzgvn9uL5wr4
 pR0xPVU5DKwI2M5d6IZnCkE5HZrv6CZ+cmFCXe9M6O0R8EwUy/VqYYMMWXD+ZaGCn6Xk 0w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jrencrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 14:03:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LE1Wfs013714;
	Tue, 21 May 2024 14:03:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js78b0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 14:03:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m536dIokqxhV2Y/vNLYuMep7iGQTBFoEsGmD8BtSPRLV7rtWBhfvxByqpNU2rnNOCmvkovvwM0dt404WLUwiZiZo+qOt8X1JM7AsU5VhnD62ePZ9lT73wOpG3NPSsxanDrsZTFFmkFqTLrwwCGdmT8gbMU+fx07Z9/1gnLUvKct9hA0qAkTBiorlTVdKDMkmCyvt6M7iDlr8Irq/QSVnweNH7UWgTwC8+W5cCVu2c1dWCXLXCF5StYO3AEIqYJVNBEQMVMEvolRIVW9Ldr6pf8d7UMmV+mouqOcN4ethvzbKu8cp2gt4QPjTzCiPUM7gwIGqTufAo4mKdYFS3+uZxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZEgsV97QtlWXMlEPberlB0hk1QvFTfLZwr60T6d/mE=;
 b=JZhNCj5oDCeVYAX8AVv0GRZ961af/+rA7HuRz1GfTutV1NrFx1SWPoIehxoRHAcCmCe4nHPOxlsXOtKBWY97MDSmVhSHD/xe2itJ28ItgC0/C4PA3b5rqLHm2PvK5TlfFKZU19bsE+ZyC7bQGODESEu6X7Nbk2n0b3/u/tUQZhq3j5X+3qAQ+g7ytm06O+Zo+Uv6Ya1j48VEN7sxbV4gmkQ9gA6c+2zDuW7lEKaE7Rw6mOaG6S1rheQerGXVzIeSr9egiqa+AmcJVE/eqs14fFcs/VBllqidmniS83PKYQ4C4uPA1GxC4DitFPXFWsyk/Du1mMan7Ld5wLTQVYUp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZEgsV97QtlWXMlEPberlB0hk1QvFTfLZwr60T6d/mE=;
 b=D9D2nOCKJOB1yVvOSrRdx1yrykGkPe9OfHes7K6vFr1/2BBwoe6R0A5cc9OsGOu2e19pWVcNh47jmcdjVXpDm1FsXe3YM/gTBokEAIPTlXFZU/83PYm6wPZry4Jf4XWC1Qde6woBbwiMy9BrE+4XZA/nBsJSsp5JSaVN/+2+EH4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5689.namprd10.prod.outlook.com (2603:10b6:303:19a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Tue, 21 May
 2024 14:03:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 14:03:01 +0000
Date: Tue, 21 May 2024 10:02:58 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Dan Aloni <dan.aloni@vastdata.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
Message-ID: <ZkypknHeBtBYJetq@tissot.1015granger.net>
References: <20240521125840.186618-1-sagi@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521125840.186618-1-sagi@grimberg.me>
X-ClientProxiedBy: CH0PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:610:32::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d1c752-9bce-4207-a817-08dc799eba2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iXUtu9DqjxZVTlR4FqCyFukCFu2UbXxR/m7TyOQzflsMo9c74BnOAXPgukuX?=
 =?us-ascii?Q?C0IPB4bOVg1sLegueyOnjCBpcMxYJdau+qWjEX8nZ8yaRw9CDMAULVhMVCnt?=
 =?us-ascii?Q?UbHTNvXRMJ0ksFqDS7/QaVXIZ8eLGaU18eUxty+HmJlPsNatNzsOsQ6Ukgns?=
 =?us-ascii?Q?dbouYehBDpbkNEZhwKmbKV3eNO3Dw+mWUzLMvNAR4teJ0Rcv7bPJ3NMLXtpz?=
 =?us-ascii?Q?A5cEbFwFv4QuOuCaSLJwHYLqdPxdTuRrkWqWcNRn8GhrcEvnF6Devb52yRHc?=
 =?us-ascii?Q?PW5F16Lx4H0F1ZUExjXDWPN0eu1UBhv2CvZz4L9gsxsx2LF7K0BuVgzc9yD8?=
 =?us-ascii?Q?MClLcfVZbiQd4l0AucwtOKZCOwFbTWpeoY8Dizgi2sDu+816D+7L0r58+V0K?=
 =?us-ascii?Q?BmGM+FP8DWnhZYvFCAZgj0BlCu5y7uBC/7rGPLz8ooBW2+CEAwnh7eTkw3nU?=
 =?us-ascii?Q?pYEF5ObTUSVdki2ykeBBZCwXrx96/FoMY8jzLu0IsJm5+Uih1t+UZ4cCIvqr?=
 =?us-ascii?Q?ruh1BUDDetvmytJNtIeD3WKsrfu3+aCEgK91cZEEiuK7UDQw+1VLA8H9IabD?=
 =?us-ascii?Q?N/SD4ZW4OVwLDOvsZUXoe6qwvNYJRsCEz5tmQU4HW+mJ2bmrrCsYA/Nq4des?=
 =?us-ascii?Q?qgARGSyiZWMdQp1RQp5Yd39ODJWVXCkvsi6flhaE9ODHgtvQLm9/onXUUYAS?=
 =?us-ascii?Q?IK4hn5lb5LuAQLeRqsNIslfmhr9LwDNKD6OGaYx++lYn7VberHL6m+20NdvU?=
 =?us-ascii?Q?/ie7xqeMIm7hq2S/B0cBGjkKubpsVBeM5nolms+PBo8etK9O/uOzK3q/wpEg?=
 =?us-ascii?Q?2B8yyjKS4lDWKGDL9Cqi0AHQUwuuvsnqLJE0AqvrLwGYdBLtzewVcNWqA4Ri?=
 =?us-ascii?Q?eA+astouD1YBiH66Bw918wYiAI3mbhEJFm9aGcgPCOgE5K0LJ7heiIjGVwPo?=
 =?us-ascii?Q?Jy/i0fujwEO6V5YblaJemaNd2t7unIC2OeZbiEOjOtFjO8lYp8Q+Hy1eaoPc?=
 =?us-ascii?Q?tLKVzZKLgjFQxRXb6jtYALzEghnLgqwohZ0e0z1R5pWKkSGU39bzV+X0xN/X?=
 =?us-ascii?Q?4Xs3m3aneVdti/78Wpj3FDRzHhA0IcUZLoHEXqrq3oQqj70rdfcElyHJ1bwO?=
 =?us-ascii?Q?U6WPDeOksLMuMN4yzUXFbjEOmHj15yqxs0SvQrB6kVomYMs6rM7nBo57AaLB?=
 =?us-ascii?Q?XojEvMQgNcHGVtfguTv+86Py4KfcfkSUBxzMMtB7wY69OgJpXTzrl6UcYjSv?=
 =?us-ascii?Q?FBb9Zb1wFDKxod+x/OS92goed3fp3od6CxNONdg8xQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9+0TM8oAZ2qbmotyiYV2tbOzdsA3Q0FZ/5AXb4FpUyRxN8VQ76aYQFXyT+/A?=
 =?us-ascii?Q?LXtwNbMD6yTuHmKjKI/Lfsv7p9tlrPhCA+aLTdX3tlObbeyeC0ywWSgUAMBu?=
 =?us-ascii?Q?l6mTtZNN8boWVlswUkUtY80kuxr4ws7T40N1Aa6RYS6Onv3c3ikLoqbwneSD?=
 =?us-ascii?Q?1vo4MBGodq+ECmO0wR0VJnpaXP8G6rlNSaActZJ65lqGg7xoTbre9pETCK0S?=
 =?us-ascii?Q?G8tGk4+hwwcX+T9IvebcUaCsDCcjzYmJLYVsRkIGeRomkCHWN/hfVBjnpDAE?=
 =?us-ascii?Q?U/33Zu/FR9ZETeTpKLv+Xch/JSOK4bEwMXe2Povj5EIXpbm4/3wRbqZzsvYi?=
 =?us-ascii?Q?Gcxh9aP5XAzrWqFttzoQ4jAxpe+YGPciJMeQLYQPY6iOpagL9fGXeQJNtnC6?=
 =?us-ascii?Q?09sR/7io8IzPL/4rCDRKYX6YQI3GpjaCuYOcOZvlQhsz/bwOqcWLiXj7cD2x?=
 =?us-ascii?Q?gaUMjMAeWUFoIYf2yIiotze7tm6WIYvLpGasC/g2xNW/ROJ1Tpjj4kh9RNoR?=
 =?us-ascii?Q?ydIaC7jVs6duCNh9LCd+6+FM9L1HdCwR9dABbG1241jCUSeDHuHu0bp2XyOi?=
 =?us-ascii?Q?rdx9mF10q5gyjsqeH2VJNGHAzsOQD5wrUlgx4Gwlrlinqk3Z/PKyrHY5cOii?=
 =?us-ascii?Q?JqAjo2jm3WUHqA5sS+D/JSgvhuDHWNNf0cjOwptMlimz4NyKaad0u8R/Hokp?=
 =?us-ascii?Q?FYAbxfDg9spDYQ3TOelJAG1Vh2Dgc47de3Tn8Qu2vtUzvvQTFh6TofgNMQN4?=
 =?us-ascii?Q?lztMOrBV61POLiA713y6FQQ9FBnjhM5cVAO2klK5hiPIAQUPByNx9LrNC2if?=
 =?us-ascii?Q?jIEvSKH+uf2Pfocpu+cFDPuE84X4p0W8haH0D7xjlqAzZbY9Daxp9D8ChuJc?=
 =?us-ascii?Q?cc2D1H2gSqPKdNHZIQBn3Hjb+pMsCS/W5wTBbHkMZ9H3fZAkGTg9jyB4xpHI?=
 =?us-ascii?Q?MUDBzWp7z57TNg+RZMc2qzaw92EHOE5ui40/CS8VBDQctmsGMK2m4rn7TBjd?=
 =?us-ascii?Q?d79/mrjtnQYncdFZy4XQo3nk9krP1+v1Gerb9oabmxqUhMU9ASlPaxvtSgCA?=
 =?us-ascii?Q?ryB7WZpfKg+a5agbMhiPq25c0YGub3H14sQywfeyZmCGhOAIW/dLhjCvIGaF?=
 =?us-ascii?Q?Riy8ySsCEJF1UXhDTg5T/8Va4s5+K0jvolW1M5OTjqBu+AQumzJsd2MdetWL?=
 =?us-ascii?Q?DhWHKqnr3f/acLb86eLwvV471eJfYtmee0Zq5HNZy+5oVBl8b8pocI58lyLQ?=
 =?us-ascii?Q?rmnmwZVVVoIWBj51imC8OAig0hbYlRLa/viPr1/aV0dlBMsnohW8Q4bmCInn?=
 =?us-ascii?Q?n/MvBxi++gh7+CTHFxkZJ+wAER/1YzmGIe9/7Dn/yzPXBU4Gfs+h44LybEG1?=
 =?us-ascii?Q?O6MvpFnmInFZJdI3jcY3csTJu2bnetbcPlxm56lo+VI4ZBywDLWV6N9ux6XE?=
 =?us-ascii?Q?1LruOOHndltu54fp52Ao176m1K1oZq4maUWOTDQ+GUS71KJ+RUcRuw/myIE5?=
 =?us-ascii?Q?0Z1pKMUPJ9ESvz+Gth4WgTnSYrkqqg/7/culhJNjXDBGULxnHvX2ZtIWBcvj?=
 =?us-ascii?Q?4PPa85hCbPPqAzu/sCZ3gSY55Akku+PcKPVxSfWHpaSOiC7Gdv8oy15vAE00?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EhFYHqv3FWX2KawpAnf/+gRlfjM1Nf5IRvZ08s/QvdO6wn1etFhwPWCjt+lSEaGF/fVt8WW3Yp5b0Lr0m8CaT6T/DJyJWo4PkBaopFFc4ovnRjaDDdRIh6cp9N+SKRp5OAp+UxQF07T6jvH+plozh4Mm0tH69y2bEf3dqmR2C0TtIAQ6k93XFJg9P0ZnivCkWTPpj8ZiQGt5N5LzSFCNlv+itMbIXpduaoqaQvIhxbq8CLVpGaDcYIX6u1tHftGjP7E+pTszyTWs+ZjqNZc/029jigIMOfpfjQ4i/qM7HCtjOL852aEqMylqdGziyS17N0pJjtQcLbdI7nIPp5DZ39Obw4cJSgtYKzHX14S33SmG3SF30KmFdRK2U3AcsttrAqwWpPnhk7DJb5mnKjYHCvF86u/aXcRPLPrrpxxyRC/6qpnwIZz3DAidPZtIKJQ+StDThhvnaoDCx4vewt2jHqPlHfMWIshcnuidtPJGgiW53J7iiiqILhPEoev94qGA5yHPebxfGi2OKrseOP6OJ3S6L5FMTlOO+15dqJwir2XzG5FqeMF9Cucnqe5CDirNa3C9ZsJgGG2OnZPXPLd80PYMUF2WVYqlPz2H0vv9TKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d1c752-9bce-4207-a817-08dc799eba2d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 14:03:01.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl2KY7CcqOm9VHqUtKeKl+4Rwa+4HoB0LT9S6uwPZ6FoN2mJYRqDZEAda0AisvGcexI1z8shfcI1iw81/lmnqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_08,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=989
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210105
X-Proofpoint-GUID: zInKXdqqPHBqNmrcuYljUoK1K9TZ8y9q
X-Proofpoint-ORIG-GUID: zInKXdqqPHBqNmrcuYljUoK1K9TZ8y9q

On Tue, May 21, 2024 at 03:58:40PM +0300, Sagi Grimberg wrote:
> There is an inherent race where a symlink file may have been overriden

Nit: Do you mean "overwritten" ?


> (by a different client) between lookup and readlink, resulting in a
> spurious EIO error returned to userspace. Fix this by propagating back
> ESTALE errors such that the vfs will retry the lookup/get_link (similar
> to nfs4_file_open) at least once.
> 
> Cc: Dan Aloni <dan.aloni@vastdata.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Note that with this change the vfs should retry once for
> ESTALE errors. However with an artificial reproducer of high
> frequency symlink overrides, nothing prevents the retry to

Nit: "overwrites" ?


> also encounter ESTALE, propagating the error back to userspace.
> The man pages for openat/readlinkat do not list an ESTALE errno.

Speaking only as a community member, I consider that an undesirable
behavior regression. IMO it's a bug for a system call to return an
errno that isn't documented. That's likely why this logic has worked
this way for forever.


> An alternative attempt (implemented by Dan) was a local retry loop
> in nfs_get_link(), if this is an applicable approach, Dan can
> share his patch instead.

I'm not entirely convinced by your patch description that returning
an EIO on occasion is a problem. Is it reasonable for the app to
expect that readlinkat() will /never/ fail?

Making symlink semantics more atomic on NFS mounts is probably a
good goal. But IMO the proposed change by itself isn't going to get
you that with high reliability and few or no undesirable side
effects.

Note that NFS client-side patches should be sent To: Trond, Anna,
and Cc: linux-nfs@ . Trond and Anna need to weigh in on this.


>  fs/nfs/symlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
> index 0e27a2e4e68b..13818129d268 100644
> --- a/fs/nfs/symlink.c
> +++ b/fs/nfs/symlink.c
> @@ -41,7 +41,7 @@ static int nfs_symlink_filler(struct file *file, struct folio *folio)
>  error:
>  	folio_set_error(folio);
>  	folio_unlock(folio);
> -	return -EIO;
> +	return error;
>  }
>  
>  static const char *nfs_get_link(struct dentry *dentry,
> -- 
> 2.40.1
> 

-- 
Chuck Lever


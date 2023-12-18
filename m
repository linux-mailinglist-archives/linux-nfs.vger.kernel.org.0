Return-Path: <linux-nfs+bounces-691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC908176F1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 17:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFB21F23E28
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD9F3D57A;
	Mon, 18 Dec 2023 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K+ZXkrM+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r7Pd0bTf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14203D576
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIEtrao021931;
	Mon, 18 Dec 2023 16:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=RQjLE9I0fXtFm06B2o1Gpxni8XYdvmI9obIEZ5LTfCE=;
 b=K+ZXkrM+r7cHOcAwBVL/DPGcSvPCrYREAW5LxDipOt2Y9Fg/sWWr84P3r9cYwVYQ/XiG
 Ih7tSbTSkhPTBcIQhlqpau4/7+dzj3RbOp296nrbfftBRBLtpC5nho6aQ4LXhDHquW4t
 kX3iPha+JPGWK+QUkKJZkjNh0hv+Q94j/NG5J+EERzAHI+XrIVPwGDkZCKj1ocez1Gwg
 L/UxN6X9+U8WOxGfmUL4CtseOAjPH4lDXAy4Vfuyon/4hQ3N+gtbn/sw81A4fXA4FQbu
 U8Hy3WY9ry563oWK9ZlpP3TP47sCRTJu1fmcQBYsm7X/L4THHJCmQF9+AqxAzASSZpI/ Ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12g2bmhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 16:02:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIG23aQ029159;
	Mon, 18 Dec 2023 16:02:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b5bdeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 16:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkV+P+OvXWB1Q+XPo3lGhwSLQXocHOv/BbDqGiSrPXDxWZtgSBEkvAk4JRacp3HM769/SYvNCWUz9vHwcUnm0HwGoX1np5oK6ZytcV/R+s4OS266qPF+A7yqj34qI48f/JCR/Prvov0F8grnU9rD5C0Hnn4ELfjYtwQ6yRlXKDERYd4mg/TxppwTCM7R/w641ubqUtSLbvgcVyMAPcrhzjH70AoTUTxXmIRjZAwoh59jlJgGb/SWQiSKbQrLQrc0F4SpiES2JhpggNbdAZdxtUvv+A4+4zi4y27sXCFEejrrrDb5SjFueVIFmetVjprpt4zD6gLfwyFqdsxR+c/E3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQjLE9I0fXtFm06B2o1Gpxni8XYdvmI9obIEZ5LTfCE=;
 b=OtErtmUTOocVyjDW5m5jYU/er8H+Kkdzc/oHQ8+bHyCbJDQW0Zf6YQWQEJDQHOpC2MTb3UyUGUq9cDdbzEgd4uAnOjLCmqSg27EekaOevtj66QlPkLvNk/psdMk7amaEaBHRnXqdHC1fj5WBSCujUxW01eJhmMaK47L7Q8dUEPekXK7tUsLeoXU2TzenT7Y8WA0ruZ4sXg3diaz0FlVYvuuGWRkGAUfrd7M5UENINDHzwH9qgFC6ho84BP2qzr2vOZF64ySgBwGbCVMuSpDyt5Cn2fae9BXM3raWTSKo5WWiCMyJV85nu09Fr6uD5gK8q8U5zgRxPpiGZI+GOTwO+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQjLE9I0fXtFm06B2o1Gpxni8XYdvmI9obIEZ5LTfCE=;
 b=r7Pd0bTfZ/MK70Q/59XXxN4WlSTA5PVCBPOim3xocflnD9zmI2eBEg+5ZbLU9vTaYjOiVD1gd5l4HRZJUnea0webLamH9FSBxDQTmI4P0uvIrK2o9xvRv7OeEnbeA9ctwH5uARQdUU3kqIjEx9OFpacQO6PpZqvOH1b59OJ/ks4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 16:02:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:02:29 +0000
Date: Mon, 18 Dec 2023 11:02:26 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: dai.ngo@oracle.com
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: Re: [PATCH 3/3] NFSD: Fix server reboot hang problem when callback
 workqueue is stuck
Message-ID: <ZYBtEs7JfMCi0TCl@tissot.1015granger.net>
References: <1702667703-17978-1-git-send-email-dai.ngo@oracle.com>
 <1702667703-17978-4-git-send-email-dai.ngo@oracle.com>
 <ZXyvCnEuV9L18JSS@tissot.1015granger.net>
 <195ba461-0908-4690-85a9-a9d12ffbad90@oracle.com>
 <ZXzIGmhDZp7v87aZ@tissot.1015granger.net>
 <aef15e6d-20c2-461d-816b-9b8bc07a9387@oracle.com>
 <ZXz7nxzlPfJ+06QI@tissot.1015granger.net>
 <1a988fe4-a64c-48c2-9c2c-add414294e07@oracle.com>
 <ZX0gOlqGbIES5RtB@tissot.1015granger.net>
 <88802128-3ae8-4f91-aeeb-69693b137981@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88802128-3ae8-4f91-aeeb-69693b137981@oracle.com>
X-ClientProxiedBy: CH0PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:610:32::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 7235233e-8650-495e-4c3f-08dbffe2bcba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RzZW+WL564KzXJlE+xuZQnW34nfTb9uiMK3Bkypn1uWSO1A0xxSK8YOT0Dpxvc81o4uR1SdlYtbbu0dOXpM6sZoVcSZzgTKkpfk2yFLd6Lc37UcZQCRbCUC081MjmQCv2UTnnNrfcnBwEB+AumMXnB+Re3/CLTNK1oa35PThbk8s8llinNDa7iEVWPsRv259hFjsBiCuKwkGYrlkkHJxVdBbB4A4JV74uXzpV8qJnKZoj5jZwnzjEJlRB1HmM7MOApGC8x5tu3r6zactQ+u34h/5xNXaS0K/j6V62XdyOR2pZgeTJnmFgh+gx5S5Qsqqt1cBvYsnw3eQTUAAdic/NkhsfSQv5jyaRYhP9Xsxs1C4dnVmCkkVnMUYB2AlnYFxk0tjHP9K6hPYW6Miq6Hi7hw4GMNFNugANImen2LblD/jgA+HyBjkcGFp35SvAwMzFdIZkKvnJPryjeIo6wAahu1XdO9fslmz8XDYSEygCbUBqjs4IWBRk9xNrCkKI4tDNO+YpV0SH4iYMjBl1dCcO8K1fresa9TeSRBQz6yCJAC3eDGo3lnATdEkW6GKciA7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66899024)(316002)(6636002)(30864003)(2906002)(6506007)(44832011)(6666004)(26005)(4326008)(66946007)(66476007)(66556008)(9686003)(6512007)(5660300002)(53546011)(6486002)(83380400001)(8936002)(38100700002)(86362001)(34206002)(478600001)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dEFjCmsFpnV83LkK/D6yeouI6lvVzWDcI5VAb1RRagdL/tu/oictkqTel6uO?=
 =?us-ascii?Q?ztjIXW7VaeBcoUZYh7CTNfrgPLf4+nEou4AQJ7qvy9Q2XC0PNnbyo7cJRvK5?=
 =?us-ascii?Q?WP7gbrVqdOlLamvh6BNobZx1HWlM7L2PVPwsxAIOD6ktuQ7Vec6TYIz7JzZp?=
 =?us-ascii?Q?g9Fqe42qQXNmLq0wgHPSLCD+vnDNlm9OcG0fqpGoBRuyDp2CDEGjW4NPc9KM?=
 =?us-ascii?Q?Qx0Ksa1Y79eIJZB2ZONIFgPS5gFH4UNgKWSJTapvchE9u0jmk+z6bQNN7Xew?=
 =?us-ascii?Q?L+EyEtO/GgNRh5Ente3Miu+I1upSTEehzY2K9XFsDeMnKN0hdOSZdb22TAD0?=
 =?us-ascii?Q?j0hhruecyVgUKbQX9794e0D89eLIQqigFz4M7DZyZGk4a0rKCo88CqH+yHo0?=
 =?us-ascii?Q?UhS/DJU+0qquQFZwLk+UX8A2+NHJBjQZxEWJ8Sgcc95erSCfzylos1fpuuxB?=
 =?us-ascii?Q?hQH0NXsUmr0auqS6WfRTIhbtkiViVLnP3G1rwuhu4vt0LYvxbVe02kiQTfTY?=
 =?us-ascii?Q?Jsr6bWZquOj9huhy2v5Ar+iqGYxxZopfmfUDj0sTnPiEFVvk9tlvvU6ezoQk?=
 =?us-ascii?Q?f09jDCE2FT1wc/Rz6susp+IGnRhwhvZ9qw3CEd1BJnpoIDpdGGzBDgoREloj?=
 =?us-ascii?Q?W6M3lvxbmbORvscRCphQebkqc96om5waf5XATYgKtB6jkBX2CC79j2cf4Ck0?=
 =?us-ascii?Q?DK9uAw7CPFSQbxl/WBhyljWgHoBVR7SBKEQ+EaLyfsJYiRPh7f5zvpd3jk/P?=
 =?us-ascii?Q?Y2ViOyw/gCkjHVHePtiH/tWlIyqx4FMER154f8JwK7YuUidTtJIteLIKSv0t?=
 =?us-ascii?Q?vsfJcN0XLO0xlfJTjckXSIuGtUbgUFl7hS/TZeKmwl9omNcpGXNhi/ThMloj?=
 =?us-ascii?Q?pMg8jbN8o8RWJ9V2QT2zsPDePEYja3h+C0NsaeC4qWCjLuUrULzPlSeI4PWj?=
 =?us-ascii?Q?MTTXctEDyoVd+2T7/ucrR0xniqrLj/dQWkRpovGYDeGAiYTkbCNb8qDmzu/Z?=
 =?us-ascii?Q?/NDOMB2GDeNCu90371f3JXvVze4XhwlItV0IkWOAhxv/K8so43SIXqjHqWm5?=
 =?us-ascii?Q?XF00Jp1pndnn8/NKcFKnljPrH5a2b0yKCgZ87Qz5dCzSvqhJ9jMxlI4+diwU?=
 =?us-ascii?Q?AyYFsy/VqaWIdvyqEvGc1hv+UNGdrMzfo9q8BY4VJsomD/VFGHAxVCmzvyYU?=
 =?us-ascii?Q?jxDlADN6BOlsil61LJ7XxAIvposAgHwY1RJ4+9sR5zZKaqpt2dptWBqhso8J?=
 =?us-ascii?Q?5D1ofn/Lu2eNRN6eoaH5lP4KsINoRhbOnAu7hxkOOJl6AvTobBeEsqcjPMKq?=
 =?us-ascii?Q?+kBQIk7j489OD8LeoqzYbUWqmHuEhqPo5cHZPcEiurwyXhf9XMUQ3Ib+TPjR?=
 =?us-ascii?Q?0ByAR7T85bmMQ3nYnxHBzVP9nEm0bgd3dvaxJbL8aM6D0gvqJR7Vq0gaUmvf?=
 =?us-ascii?Q?cILFpXvJszZTKpmwccdghIaVqf/SAY/5dTUiyrwSskPnbB3BHwIZ6kbr9uOx?=
 =?us-ascii?Q?plmhVfYcUuLUG4ddg1LIzwgh/Cxb3Fu5M4HC3eERWarEF0kTZbj2N1Hd0PRf?=
 =?us-ascii?Q?doT+ubn6E6Jbuuu1uIvyStmXxu6UJC4FzPQeQ55z6GKmtAOr2ei2bn1Zsi1a?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0VlnxBsrBakXZiTqrn0MobLTnpohNpFKTns3CnuExDlVUO3WfS0bOSWvjIZW0R9WzjuIRkEUabKlTIf9DhE3tN237Pak360RlLj2hpqIelbU5AlAlYS8tumaKk5xOy6vpY6OFj/qG3pmUFR4NbIlcZKqpW2L4TcIhgfbj9WX68fU89mCZi8pyh4OjagS+zYrH3s5OGCW7qwjhRmkZvgbGwYALGOke+y9FEz9MMQOzSzFN93v3uuvAGk1MTwpmEEh6DVPLik0fBi2egF47CBHDF4COZFK53lu9kvPMHqyNM6Bq9bC7w1lezPhtiSHqxPbE22hBF4L/H/bRlq9AxP2V9wJNmlbGsgFFOAj+kkCQVH4ebOLoAsflPp/vPilZ+aVyHZqrUG3Utd5aS6j/a3c//A+uKRKsC345+WxmejFBJNvTbGVWdzOfJqbS3gkJVQkUZ1FZM0V1QvoK+dxHcKiGAKQ912DKeEILPNHhzk3VhgPrpkaxFwntP9olQ+ejfMIlBvbnp7LS1Zo//D7ooKVv0iIjQIYT5/p6XeAY6p1JxAzOv6xNfomYhCfgFpGJkEqDyJAy4LjiO4szgcvMIH+YdL8GggKHRREGjk2Ohi/2mw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7235233e-8650-495e-4c3f-08dbffe2bcba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:02:29.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mg6vZ8bb/urQn98+CVa2IgAdzCfyAk2dLFTppu30FY4eyrH8XZ/ZEWUCc4Ty5mjJhHfAxHMwYVtZAMyIbaKd0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180117
X-Proofpoint-GUID: 3ZTldic-vjxAfITkL038Dlk7KOkB-qS4
X-Proofpoint-ORIG-GUID: 3ZTldic-vjxAfITkL038Dlk7KOkB-qS4

On Sat, Dec 16, 2023 at 02:44:59PM -0800, dai.ngo@oracle.com wrote:
> On 12/15/23 7:57 PM, Chuck Lever wrote:
> > On Fri, Dec 15, 2023 at 07:18:29PM -0800, dai.ngo@oracle.com wrote:
> > > On 12/15/23 5:21 PM, Chuck Lever wrote:
> > > > On Fri, Dec 15, 2023 at 01:55:20PM -0800, dai.ngo@oracle.com wrote:
> > > > > Sorry Chuck, I didn't see this before sending v2.
> > > > > 
> > > > > On 12/15/23 1:41 PM, Chuck Lever wrote:
> > > > > > On Fri, Dec 15, 2023 at 12:40:07PM -0800, dai.ngo@oracle.com wrote:
> > > > > > > On 12/15/23 11:54 AM, Chuck Lever wrote:
> > > > > > > > On Fri, Dec 15, 2023 at 11:15:03AM -0800, Dai Ngo wrote:
> > > > > > > > > @@ -8558,7 +8561,8 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode,
> > > > > > > > >      			nfs4_cb_getattr(&dp->dl_cb_fattr);
> > > > > > > > >      			spin_unlock(&ctx->flc_lock);
> > > > > > > > > -			wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
> > > > > > > > > +			wait_on_bit_timeout(&ncf->ncf_cb_flags, CB_GETATTR_BUSY,
> > > > > > > > > +				TASK_INTERRUPTIBLE, NFSD_CB_GETATTR_TIMEOUT);
> > > > > > > > I'm still thinking the timeout here should be the same (or slightly
> > > > > > > > longer than) the RPC retransmit timeout, rather than adding a new
> > > > > > > > NFSD_CB_GETATTR_TIMEOUT macro.
> > > > > > > The NFSD_CB_GETATTR_TIMEOUT is used only when we can not submit a
> > > > > > > work item to the workqueue so RPC is not involved here.
> > > > > > In the "RPC was sent successfully" case, there is an implicit
> > > > > > assumption here that wait_on_bit_timeout() won't time out before the
> > > > > > actual RPC CB_GETATTR timeout.
> > > > > > 
> > > > > > You've chosen timeout values that happen to work, but there's
> > > > > > nothing in this patch that ties the two timeout values together or
> > > > > > in any other way documents this implicit assumption.
> > > > > The timeout value was chosen to be greater then RPC callback receive
> > > > > timeout. I can add this to the commit message.
> > > > nfsd needs to handle this case properly. A commit message will not
> > > > be sufficient.
> > > > 
> > > > The rpc_timeout setting that is used for callbacks is not always
> > > > 9 seconds. It is adjusted based on the NFSv4 lease expiry up to a
> > > > maximum of 360 seconds, if I'm reading the code correctly (see
> > > > max_cb_time).
> > > > 
> > > > It would be simple enough for a server admin to set a long lease
> > > > expiry while individual CB_GETATTRs are still terminating with
> > > > EIO after just 20 seconds because of this new timeout.
> 
> With courteous server, what is the benefit of allowing the admin to
> extend the lease?

The lease time is the time period during which the server
/guarantees/ it will preserve the client's locks, even if there are
conflicting open or lock requests from other clients.

Once the client transitions to courtesy, those locks can be lost
due to conflicting open and lock requests.

Clients need to know the server's lease expiry so they know how
often to renew their lease. That's the only way lease-based locking
service can provide a lock guarantee.


> I think this option should be removed, it's just
> an administrative overhead and can cause more confusion.

A server administrator might extend the lock guarantee by several
minutes if her network is subject to frequent partitions -- that
will result in long workload pauses, but it will /guarantee/ that
locks won't be lost during short partitions.

The only reason not to extend lease expiry is that it also
lengthens the server's grace period. If the server is accessed
only by NFSv4.1 clients, they can use RECLAIM_COMPLETE to avoid
long waits after a server reboot... but with a mixed client
cohort, a shorter grace period is usually preferred.

We have the tunable now, so I don't see a lot of value in making
an effort to deprecate and remove it until NFSD no longer supports
NFSv3 and NFSv4.0.


> > > To handle case where server admin sets longer lease, we can set
> > > callback timeout to be (nfsd4_lease)/10 + 5) and add a comment
> > > in the code to indicate the dependency to max_cb_time.
> > Which was my initial suggestion, but now I think the only proper fix
> > is to replace the wait_on_bit() entirely.
> > 
> > 
> > > > Actually, a bit wait in an nfsd thread should be a no-no. Even a
> > > > wait of tens of milliseconds is bad. Enough nfsd threads go into a
> > > > wait like this and that's a denial-of-service. That's why NFSv4
> > > > callbacks are handled on a work queue and not in an nfsd thread.
> > > That sounds reasonable. However I see in the current code there
> > > are multiple places the nfsd thread sleeps/waits for certain events:
> > > nfsd_file_do_acquire, nfsd41_cb_get_slot, nfsd4_cld_tracking_init,
> > > wait_for_concurrent_writes, etc.
> > Yep, each of those needs to be replaced if there is a danger of the
> > wait becoming indefinite. We found another one recently with the
> > pNFS block layout type waiting for a lease breaker. So an nfsd
> > thread does wait on occasion, but it's almost never the right thing
> > to do.
> > 
> > Let's not add another one, especially one that can be manipulated by
> > (bad) client behavior.
> 
> I'm not clear how the wait for CB_GETATTR can be manipulated by a bad
> client, can you elaborate?

Currently, a callback is handed off to a background worker and the
nfsd thread is permitted to look for other work.

If instead nfsd threads waited for callbacks, then a client with an
unresponsive callback service would pin those nfsd threads for the
length of the server's callback timeout.

If the client's forechannel workload is actively acquiring
delegations and then sending conflicting GETATTRs, it will keep such
a server's nfsd threads stuck waiting for CB_GETATTR replies.

And since those nfsd threads are shared by all clients, all of the
server's clients would see long delays because there would be no
available nfsd threads to pick up new work.


> > > > Is there some way the operation that triggered the CB_GETATTR can be
> > > > deferred properly and picked up by another nfsd thread when the
> > > > CB_GETATTR completes?
> > > We can send the CB_GETATTR as an async RPC and return NFS4ERR_DELAY
> > > to the conflict client. When the reply of the CB_GETATTR arrives,
> > > nfsd4_cb_getattr_done can mark the delegation to indicate the
> > > corresponding file's attributes were updated so when the conflict
> > > client retries the GETATTR we can return the updated attributes.
> > > 
> > > We still have to have a way to detect that the client never, or
> > > take too long, to reply to the CB_GETATTR so that we can break
> > > the lease.
> > As long as the RPC is SOFT, the RPC client is supposed to guarantee
> > that the upper layer gets a completion of some kind. If it's HARD
> > then it should fully interruptible by a signal or shutdown.
> 
> This is only true if the workqueue worker runs and executes the work
> item successfully. If the work item is stuck at the workqueue then RPC
> is not involved. NFSD must handle the case where the work item is
> never executed for any reasons.

The queue_work() API guarantees that the work item will be
dispatched. A lot of kernel subsystems would be in a world of pain
if that guarantee was broken somehow.

So I don't agree that NFSD needs to do anything special here when
queue_work() returns true.

The only reason I can think of that queue_work() might return false
is if NFSD hands it a work item that is already queued. That would
be a bug in NFSD.


> > Either way, if NFSD can manage to reliably detect when the CB RPC
> > has not even been scheduled, then that gives us a fully dependable
> > guarantee.
> 
> Once the async CB RPC was passed to the RPC layer via rpc_run_task,
> I can't see any sure way to know when the RPC task will be picked up
> and run. Until the RPC task is run, the RPC time out mechanism is not
> in play. To handle this condition, I think a timeout mechanism is
> needed at the NFSD layer, any other options?

The only reason you think a timeout is needed is because you want
the nfsd thread to wait for the reply. That's just not how NFSD
handles NFSv4 callbacks.

The current architecture is that NFSD queues the callback and then
replies NFS4ERR_DELAY. That nfsd thread is then free to pick up
other work, including handling the client's retry.

It doesn't matter how long it takes for the callback work item to go
from the work queue down to the RPC layer, as long as a subsequent
server shutdown does not hang. Either the client will reply to the
callback, or the server will see that there was no response and
revoke the delegation.

(Note that we have nfsd_wait_for_delegreturn() now: it does wait
uninterruptibly in an nfsd thread context, but only for 30
milliseconds. The point of this is to give a well-behaved client
a chance to respond without returning NFS4ERR_DELAY -- if the
client doesn't respond, then it falls back to the architecture
outlined above.)


> > > Also, the intention of the wait_on_bit is to avoid sending the
> > > conflict client the NFS4ERR_DELAY if everything works properly
> > > which is the normal case.
> > > 
> > > So I think this can be done but it would make the code a bit
> > > complicate and we loose the optimization of avoiding the
> > > NFS4ERR_DELAY.
> > I'm not excited about handling this via DELAY either. There's a
> > good chance there is another way to deal with this sanely.
> > 
> > I'm inclined to revert CB_GETATTR support until it is demonstrated
> > to be working reliably. The current mechanism has already shown to
> > be prone to a hard hang that blocks server shutdown, and it's not
> > even in the wild yet.
> 
> If I understand the problem correctly, this hard hang issue is due to
> the work item being stuck at the workqueue which the current code does
> not take into account.

The hard hang was because of an uninterruptible wait_on_bit(). What
we don't know is why the callback was lost.

- It could be that queue_work() returned false because of a bug.
  Note that there is a WARN_ON_ONCE() that fires in this case: if
  it fired several days before the hang, then we won't see any
  log messages for more recent misqueued work items.

- It could be that nfsd4_run_cb_work() marked the backchannel down
  but somehow did not wake up any in-flight callback requests.

Let's get more details about what's going on.


> > I can add patches to nfsd-fixes to revert CB_GETATTR and let that
> > sit for a few days while we decide how to move forward.
> 
> The simplest solution for this particular problem is to use wait with
> timeout.

The hard hang was due to an uninterruptible wait, which has now been
reverted.

Going forward, if there's no wait, there can be no timeout. The
only approach is to handle errors properly when dispatching a
callback.


-- 
Chuck Lever


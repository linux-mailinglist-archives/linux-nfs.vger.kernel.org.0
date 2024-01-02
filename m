Return-Path: <linux-nfs+bounces-864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801DD8221F7
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jan 2024 20:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F1BB2256D
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jan 2024 19:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769BE15AF6;
	Tue,  2 Jan 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aFTfdHHW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t2zyPjuZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FACC15AF2;
	Tue,  2 Jan 2024 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402IgXEE020149;
	Tue, 2 Jan 2024 19:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=z57RbqVINWgM5C1/ysfD44cMxFjc0HAHf71HXfuee+I=;
 b=aFTfdHHWboYs2FT1wLE3Eomrh9tvVKOwoOc4L1eN2OZVlq4bEvUaHTFep0TNO0dc3m4l
 mQhoLtCsf6iFregxJUvJLdMmKTD41jsvqUftl4cWoaGKxdTTlOovZOyN5rMcScAXvatJ
 1iJ8ZEyKzoH0ENIqcPE7y6VL0oY1hd2z5QhaVHNMrnpOCEsAbJHuDKaeik/8Hvg+nSQ4
 vvTucD/9++YkhlX0dfdf+sXYDRMZrgNlAM0Y+4oP3P2TGqxk/2XUNQLPsMXHg63BxAYQ
 niI017qscqsLfR9B2gh7UjGJJpC31/1NxQNBN2yUiGZvaw1W0GB13YHBBOFq4be+Z03X Iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab8d3pwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 19:27:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 402IVrZi001582;
	Tue, 2 Jan 2024 19:27:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3va9n7px5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 19:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE147d6BGV+WfaubFTZA12CbaeTV7z5bUoQiliDdikjQsVL8qJkp2oKrplc0WniFMQXHGyyeJPfH5I2N+j7pWX2ZhIxvU0byRAF2s+dEjayx1ZNvrx4QYMBG0pSbnYQ6AVpNHvhpuWhKyFv1ipsyGxLO1PNMtcC8XneIp8FpsG7LjRCdlnyAZxjbG3Krq/Zon+AKJlKRRfwzgcY7v6NdKrrETjz4FhwN9ECnIOKyYtM+jX8qSHbDg3AAa7lalZNdY4DuQh8s8M2JicZv0GPdyfZbBHkMf51B9Y6Hhzmixx+FqWP9a85K+4lbrNHvi4+5ydQ6D8KmHhXK+wcqk6O52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z57RbqVINWgM5C1/ysfD44cMxFjc0HAHf71HXfuee+I=;
 b=L97OxHo994B2CPgenQZ3aBv8WlzsieMlj4tyJ61ys3JwJcCYyIQjeawFndAqTLEmol08aqysQaBDWao//b9+Ggx/1X2lWDgq3tkjOrzuQw6EoQKpgqn7z8AQDLtKu+XsNuziKFoG5dGJj2+hjkyaeKJFqTn6V5RVh23g1UL8ntZhgZ26a8Tz3wjESyObw5QZ/JMa4dRZ6PPiLbs81ezz1Jg+MrWtNklGOYLJcJaAmm8nI/zC3vDysvHKOja0lUpolhwrOf4cSJyhg0WHCZ3sHZ2Z9IKQD4mfcJOJNHTkivGGIkOVZ4qcw3j/457reyLjmFX26R89srC7JeV8I419ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z57RbqVINWgM5C1/ysfD44cMxFjc0HAHf71HXfuee+I=;
 b=t2zyPjuZut6LEQ2gz+SBkbTCRB209g2gtxC5kI9cpr4m1LjhsbCTUx7Oy9/P7ElZ6vEjrvuLH5gX5n7l9Ji2ITBWc4//if3b3CXtxZcbbBerXmD/3pwWvEaGeNM+1MT34EG4S7fkIc6mV+urJmJI1V5C90zQ/yAwIf/kLmvwOYU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7936.namprd10.prod.outlook.com (2603:10b6:8:1b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Tue, 2 Jan
 2024 19:27:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.013; Tue, 2 Jan 2024
 19:27:20 +0000
Date: Tue, 2 Jan 2024 14:27:17 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>, Simo Sorce <simo@redhat.com>,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] SUNRPC: fix some memleaks in gssx_dec_option_array
Message-ID: <ZZRjlXwc1kIUJKaJ@tissot.1015granger.net>
References: <20240102053815.3611872-1-alexious@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102053815.3611872-1-alexious@zju.edu.cn>
X-ClientProxiedBy: CH0PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:610:77::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: abc78cb9-543f-445b-7b43-08dc0bc8d6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wfSboHH67v9KdYqR43qjllC88vK7+gCzFdTYsJr2hxlhaVHBPClz5279GAFyXvUjDunnnN2PMjHmJRaUM6dSE9pAxj4KDiG5Uaq91Rrba8zQ7pJIwLaJV6LVfnVK17EqccSLFPdKAf5YREGRbrVg+E3ELp2ZFNrXbSG78K6aIHt/XjJBe4D+Qenh3//1ddSRQrGFURCkz0nAh9eFzCRM0/3NY2GvpQlBmsgGznDzmfYw5SYZIPfocBh6E578/WBfS5ltrk6VXC3de8tDoFrdvUrBIAmtJZPHdGcdjrnvGGZK7eoBRGwGq9ffhU61iDoK8BwaZ93av+d5zpdS76XjUT3BzM6GqX66FZVvAYvZInbu2susajr3r9plYvnqIOaQt629IKX3plI4DTTb1Rbs6dGDGfDdK+cNpPAJIjr5Fq6lCmFejAUeBKe6cWR41G58qsxUX3RHin8Wpjhzx85/S3SqHfOUkFU+bk2vqqrMCcH4PPQuyWUx9SqXTQBnUggNOPQ4aGAv7jOncqhTiRAay1xlcD9WHYsd88eybmHiSB0wdrTCPSbs9wkN9/WJ73Ag
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6506007)(66946007)(66899024)(6666004)(66476007)(6512007)(66556008)(6486002)(9686003)(86362001)(38100700002)(4326008)(26005)(83380400001)(7416002)(2906002)(41300700001)(8936002)(6916009)(44832011)(8676002)(54906003)(5660300002)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hWpKYp0xVZR4hO/6F8TcOFZKgeQWspr3hb84T9/icV4VDln/1uHOe1sFmqOC?=
 =?us-ascii?Q?uqjCJgQ459CjXVkD4FqAUmRxwxGLaBv2zvlB35aS3NdTrZ7NA4fGQo0dQibN?=
 =?us-ascii?Q?Uwy2CZmAQzbIPMZ6P7AHp3LkTnr1QY7mvUMnnkpfO/xm5YA8fZYTAG5/oEvC?=
 =?us-ascii?Q?kXzsUMoajffh46YAZM7eVU/hwv+a3hBZ0G7gRS9Xv89MCcSaNqJ+55vK5orX?=
 =?us-ascii?Q?nQodsVEZ75/0nwYNTuoKOX4vwRx5by7c3Bfk9TC5JgGSLF98EaQj4+Kw5Mgu?=
 =?us-ascii?Q?Igp+llWL8HjJXHdeqL5sszeAMjiCKyu7hA9rpUrrpEId4cxatl5xQYdyfDuk?=
 =?us-ascii?Q?IPbqOn41UdGmf6XpBhY2WVQ89iesDrgUONb1w1OjvX9cPBnAxUMJjIg2sFEF?=
 =?us-ascii?Q?HsxlhaBTclnk6DVxzZaKN6ao/PDAUWz5Spjsa7QxiH+NlQn6kJnFL/j3IxQ/?=
 =?us-ascii?Q?aV/YwSjGVNJRZICIbWD3PYY+hcQCHzPzOWx/S5FBYdwTTv1bhgioyyOcaEQw?=
 =?us-ascii?Q?BbZn8G+x/6maJuSrQa1MRkBBPM6G9wqZV9tqa8BXugSUiqJcApkSxZ3Xni0M?=
 =?us-ascii?Q?/4C0YYY1FvbsXzzXCaMXeLQ8ONsXLFgK1NQMkVyDMPAbJHn1L/4ItttmivN7?=
 =?us-ascii?Q?a6EblhTnpbyz0NEthL2fFfhMV8RfyzJdigqMtqnHgwLE95W/BJDV7bdZvCzb?=
 =?us-ascii?Q?roIeR5WdJfRKMJ3ZvSe5qiP2VFmVWrZ0ETraH6RwW+TCfYWk2cnrPF3K0u8I?=
 =?us-ascii?Q?4TolCuBdus2K6qWTDgN430p5Lu9pctMfv0Uf1MhXs60zq+A+jn4MS999U2hh?=
 =?us-ascii?Q?iL5Nm6sZyvBVMIL81o5IZrKsAfIW/twpGDq5euLUso2PvzWWAHHJ4dpzcmgA?=
 =?us-ascii?Q?EeA1eYO0jNB1XR6E5HZ84HPQgXBOTnbEGxg5/SGitJu6FpKbDogmv9lgQWNK?=
 =?us-ascii?Q?gy+vlofHzYChNokB+MbxbNCt3BdVncS3EJQH7qRcUrauZ+Widben5YKpJ428?=
 =?us-ascii?Q?JMLxvoXdQPdCbguOnqwzDYY0gj9Vyn8xyhpeu+K3O3G9tTW6A66xH3ZkXpUh?=
 =?us-ascii?Q?EKHM/gyVaOdlnaEWLfzbWesyxt57IDHveWgw2rKyJTBKal9FBqOc0ReeSJvO?=
 =?us-ascii?Q?Po5+6XyKYcP0lik9iLrh8DRQrcJPH1d8Iuur1jRNm4r9QGn5ZO4GL1bnYrmy?=
 =?us-ascii?Q?kP5f16hQWbb1in4QludLBjVR+7Qebz1dfOSH+kDlQFSF0PlOfsZugAnVd+E8?=
 =?us-ascii?Q?8DMl4CfsTB+KNimw9OUs3sBMNqCTSwlvNt8XhGnAVu7NFiSrX+FKmKfTFxdX?=
 =?us-ascii?Q?ucFAsfhMaz8HQO8Uc2OVAUl2X4qKl+Pz9dZOxGgRCsXHyWPa6PKUuAuWU/vh?=
 =?us-ascii?Q?5Yf0WKLhc5TDIl4Un5j8DuouQGsmegcBBcOsEp+836eXuSfr5H2P0knlukof?=
 =?us-ascii?Q?nZUOO9rIaVBmTiGRUi4/VbAfUX3OtteKWMrNsingCQ9y3RxbZ5XNv8YKGzJq?=
 =?us-ascii?Q?diedgVC2RnXBmr5IGCCo+OHpDvFA4cz6PTvZ1kZCeBJet7zECBKfIMIK+8ZE?=
 =?us-ascii?Q?b7xM/++Awe0AFXiFYyBVtESYkT1yPMrRr8W/ZR63m4Y6gWfecPszlAQNRQfa?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oONDZ5OSKWYJxVwHz5r1AA70jpVv9Fp4BAfpmbV6cjQvLzDXFTqPB+8rV6W8E3kK7DP2+fQcfmmz+HCPcOltPDw8QO4mrtgZJZukclda+YQV004TKqRPsudGE0HlbDEBaa1XecGNV13c8yadVtfL0ege7jxONGaHXsFsTl0dSTQCvHrNTqYip4vUpLrWzWSy3+g3IJErz0COWMatqFXgr1H/7I7NMqD+YVYUDR4IcCS/akjv+aY56z7pTnA3pxvKQYgq27qVkfA7wutVbEttVITTdna9yNUobLtkz/ltJlxEig2IzNFzJm1IDJvnjjpCpFN77WO5x1uVuq1BW0l8JGxLJCohinPTcKkWjJx0Mds+qlEcUQyUu63232KhvYzhgrCzeGHeRSP0dWVSdH9OnrHbQwGdaSgHprCO0rDENdniEoRKujK6t2B5WSoSW8ZRWrjiTpXL/SfkMFAHXp4QpnjmNP8d6pBpea9TGCkbeEQiM/vqpODedcfQeSCSOmwYSrcfHWRRIP9lYh+pgaVbxu2OG5WXBGWqmUkOF14wFOVEL3nIMa31k9vZK5OGwUQk8pmR48V7tcYQDIiH0C6eUNcjH+MZluQ5IhZZoQQWdXk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc78cb9-543f-445b-7b43-08dc0bc8d6d7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 19:27:20.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUGSlGvisXVxUtzApbUaTBszBceSPrAJ/jUJCdfCU/5bfHhGS6yni++Bne4ljjgXmq48tTY1wXRZsKDb3Bm4/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_07,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=610
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401020146
X-Proofpoint-GUID: nEMuUVprBzP7HOkJShKhYkFVd3Lg3cVL
X-Proofpoint-ORIG-GUID: nEMuUVprBzP7HOkJShKhYkFVd3Lg3cVL

On Tue, Jan 02, 2024 at 01:38:13PM +0800, Zhipeng Lu wrote:
> The creds and oa->data need to be freed in the error-handling paths after
> there allocation. So this patch add these deallocations in the
> corresponding paths.
> 
> Fixes: 1d658336b05f ("SUNRPC: Add RPC based upcall mechanism for RPCGSS auth")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
> Changelog:
> 
> v2: correct some syntactic problems.
> v3: delete unused label err.
> ---
>  net/sunrpc/auth_gss/gss_rpc_xdr.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)

I've applied these two patches for v6.9. They will appear in
nfsd-next once the v6.8 merge window closes.

Another comment below.


> diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
> index d79f12c2550a..cb32ab9a8395 100644
> --- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
> +++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
> @@ -250,8 +250,8 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
>  
>  	creds = kzalloc(sizeof(struct svc_cred), GFP_KERNEL);
>  	if (!creds) {
> -		kfree(oa->data);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto free_oa;
>  	}

I recognize that this patch does not introduce memory allocation
in this function. However, the general rule is that XDR decoding
does not perform memory allocation: that is supposed to be handled
by the next layer up.

But I don't see a good reason that memory allocation even has to be
done in here, and in fact both of these allocations are fixed in
size and number. Would it be nicer if these were made fixed fields
in struct gssx_option_array ?

Not an objection to this patch, could be a project for another day.


>  	oa->data[0].option.data = CREDS_VALUE;
> @@ -265,29 +265,40 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
>  
>  		/* option buffer */
>  		p = xdr_inline_decode(xdr, 4);
> -		if (unlikely(p == NULL))
> -			return -ENOSPC;
> +		if (unlikely(p == NULL)) {
> +			err = -ENOSPC;
> +			goto free_creds;
> +		}
>  
>  		length = be32_to_cpup(p);
>  		p = xdr_inline_decode(xdr, length);
> -		if (unlikely(p == NULL))
> -			return -ENOSPC;
> +		if (unlikely(p == NULL)) {
> +			err = -ENOSPC;
> +			goto free_creds;
> +		}
>  
>  		if (length == sizeof(CREDS_VALUE) &&
>  		    memcmp(p, CREDS_VALUE, sizeof(CREDS_VALUE)) == 0) {
>  			/* We have creds here. parse them */
>  			err = gssx_dec_linux_creds(xdr, creds);
>  			if (err)
> -				return err;
> +				goto free_creds;
>  			oa->data[0].value.len = 1; /* presence */
>  		} else {
>  			/* consume uninteresting buffer */
>  			err = gssx_dec_buffer(xdr, &dummy);
>  			if (err)
> -				return err;
> +				goto free_creds;
>  		}
>  	}
>  	return 0;
> +
> +free_creds:
> +	kfree(creds);
> +free_oa:
> +	kfree(oa->data);
> +	oa->data = NULL;
> +	return err;
>  }
>  
>  static int gssx_dec_status(struct xdr_stream *xdr,
> -- 
> 2.34.1
> 
> 

-- 
Chuck Lever


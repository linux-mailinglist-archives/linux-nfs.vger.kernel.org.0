Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34D77CDC6D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 14:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjJRM4n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 08:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjJRM4l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 08:56:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBE7106
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 05:56:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBJJEC000459;
        Wed, 18 Oct 2023 12:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=k5E49W4B9NA21TLFk10d2ih/KVZbv7V2nLX0SHq9F74=;
 b=GinQ2eHWT6HbAb0sSmytdJrs/2QKQ/qftc97vNGuuMcywocqIOOJrbyvY5Jbg88fAZeD
 eViltk3IjTSIlcsNwfgcPj+OKFuUkkbvRM9kGjygKbxLta4bh69ZnJa+/qnyLcvrCnfr
 FWx1Hc+MeugIX8x0kneG3935sTNZcTAOb6VLHiSAgr5N49fATrQ06Hw7lbDz+UfEaoY0
 8oBtnlqFmHFkpuKaXtWJVoLeTFZoJtCdT4+ugdxFAQ2Nl/aPUxywgIl8QFry9jR7pQh2
 V2njvk8sx1lz4auL1iKBNOvJVy4SaS0CNX7BmxboI8sVTmAcUEz1a8YZCGS7I4ya/b/m Ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jqfrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 12:56:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IC2G5N015292;
        Wed, 18 Oct 2023 12:56:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1gew6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 12:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6ShHzqGZN5IUlQT+ArSZIp3MybQbgLWMkoxInbEGQ34lu02lSY4Y6gzht+9i9wYT+y3pGscMteOOCuUH7r20J7sFAjKvZFvtHVXyLHRjpIySgztonESzt5o4DobskXMsc4vTkNMaQa5sqOQo2mUU2Yn0RNCbUjM0U3W3BPtCAD8Li1x82smn3cLYqrYDJarHWvM4sefQgsoUvW7j56Hvia8AEmWXG7gj1pdQ4weWXKCuv/S2w8Wmpd16S+VupFnrMvez6b9CpG9r7cEPMhnL3qvB4MUkCP5VEuQvjdeR9sce34zi0bRer5lZok/htanDKGNwEt9selaZUE7Xh10rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5E49W4B9NA21TLFk10d2ih/KVZbv7V2nLX0SHq9F74=;
 b=fRjD9vkPlp6wgUr1bh1gUPIzB3F6zbFkW2gTqySR2q8lWpGM03l6eMprIBlEN11qjGHq9/sE/YRHXmvxZqIwM/wYd+SThyShJZW1V/agy4dZfSXwGfUWe9t8kpqks5fqB6foR3S3j0RKgOvN8AWbTjqYgn3tGOwwTpB2+5KSiazlLS5m0+Y4lEWi3b+izD9r3tJ+9SOiU0JPSdtjorrpu/Scn89HMoPltHY4TfPVPlFe/2NpDFEnHgyoCdnnxy3Hktf7B3UwKA4arndykykYXMb+zUBelx9XiZLDrRJeQx6CMaOiiyVWFGdwgLQGsVgx/9ooXs9R89W9X8Ohx0S8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5E49W4B9NA21TLFk10d2ih/KVZbv7V2nLX0SHq9F74=;
 b=ckH3Q1vT6GkXFFEp2UeD4/B0hVPlyL778M5nQt9zUa9E715rzhg/qppxmO1buLKf+qfWNQLTW+lq5NKIxEpS5PhBW4V+6BdLPw3f4sFZ7Jz7G2Z1Y1qkowv5RihiNBhUOE3LWVFE1kKOBV5UBUDbTfu2bRbLovCAeVhJoRkLDlI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYXPR10MB7974.namprd10.prod.outlook.com (2603:10b6:930:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 12:56:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 12:56:30 +0000
Date:   Wed, 18 Oct 2023 08:56:27 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
Message-ID: <ZS/V+4Cuzox7erqz@tissot.1015granger.net>
References: <cover.1697577945.git.bcodding@redhat.com>
 <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
X-ClientProxiedBy: CH2PR18CA0042.namprd18.prod.outlook.com
 (2603:10b6:610:55::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CYXPR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: a1dba78d-5f8c-4538-d75d-08dbcfd9a5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNupK3GJxrPmfrPMdVzIeWceTxbCHYRwqyk6iP1a9DnbLJYlhLeJWyRK41a2CzASJ30JToRYhd1nb5z9r5WDOJ/u9vpX+1j3LenDeTzhizOZCSWX6wrTe9+eXv6mp+5Kn8PrekWVluaYMUmqQACHVKbJ/zPPhTMAUijZRouayT0HmY+1f9DPKQZNfJ1VljtmChD9lkXWxANsFXZWvKctb32SvTRVmNjNQwUsn8WOpLXPlVFfsmT65ThoJ1ncrLCTbqCHC5E/EGV9qkhVwymKFbi1sH+L7fz8IcSpKEuxVazvjdaNDYGVFLPnHaCLAxlMbeQa+f5naE3O4te4NzzbpfF0jWD8EOZHN/NVONe82TCUbzwKzp58NRngwRWR8Zls2BIEM3bkZDvkRUrqlq4A8i9hycs1A7IK7VpJcjKbuEBRQzmTkoSyDUFGTBdPoI0Sxo/uaCgbh60mYVKIxzMkc7m9Km9eAl3kF/lwy3X4fmf3Ln54tq8waOgVVDRqh+wl/AibZfsgffwWZb/qU6yRqdPgDuLM412rgA4BA0CrxH2dhy3WrsZA1INXirNSB8Fn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6486002)(6666004)(38100700002)(83380400001)(6506007)(66476007)(2906002)(66556008)(66946007)(478600001)(316002)(6916009)(44832011)(26005)(86362001)(8936002)(41300700001)(6512007)(5660300002)(8676002)(9686003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?liRAEdY3eNtU7U96QpEXaHIOQqkdAq6JMrRFE12NNOntqai+d4hoCCLPwQq+?=
 =?us-ascii?Q?7wD/kBs6xsZr0pXhOVxAq31lB0mIvabgmoxgtoigjocVEyBphH5jeNjHkfUd?=
 =?us-ascii?Q?IGUPKkqB9gG5nhvESYBsi+d8e2l3ng1UrWfcmTkyWma7W3+7ByreS6H9dgPE?=
 =?us-ascii?Q?P7PhLUMTOEfTc2FbVzLntV6MldnOjycvTPuwoEGIF2xYtsn/YSGEmXv1bX8k?=
 =?us-ascii?Q?IX+94JlyrBwAulGNmOe9VhbnaX0sXMlAqEQxRnp6YwRzrYDBdYHf29iwXR4r?=
 =?us-ascii?Q?SJoB+FnLvgmSN6oKpp6cTSve+2fpSbvQAmaShTcb6MDMqMvc+1bGo2izDoIp?=
 =?us-ascii?Q?6r/jFmaAKYNV+LAgbGptowlImJsfC2tJAKPKU3iPgEYZ8FFGK6aoVQ3LErtv?=
 =?us-ascii?Q?/90cxCWR7VMbEkJFz84Pd7CoypO91pTuFfNCLRlXIn7I2sdmE9Qzlgtsq4Sf?=
 =?us-ascii?Q?NE6FeskRPqGR+NKxV9nwHfGPn76+G2jaHvt+zvcDJgmoC8gy85NpbdsICw7w?=
 =?us-ascii?Q?s9fNQibQeAkWLwHeiCftyG/SlfecjqUkXD7Hil6h2DUo3crwokyfujSGoZMH?=
 =?us-ascii?Q?sk9sRpwLFVuvwiG/u3PANnwUmMuq2o1JJRqzwuIwZh+/FpVD0SkFdMWTkyRp?=
 =?us-ascii?Q?N/6BOpig9NZSm2u7Y068QrV+GIVHNpY2pDAqCRrqd55Cyvj6+x5LDmlwvUwJ?=
 =?us-ascii?Q?EzkhgH1msQTiSo2wPuyjpOP8Xda/vtL6tO4Z7wjrTiOPgcyq8H/77H6VQQpC?=
 =?us-ascii?Q?ucO/+Ey9eQyVy71FIISBDietkDXInaRv113sAYI8W+/ROoisCSthA8ukWp0A?=
 =?us-ascii?Q?5OmXz8G5kdJoaEjY0NI4Ml5Pub9w3pL+incncJQVSz17HKIWQ6bnOadrWejD?=
 =?us-ascii?Q?VjsHH62lcRqo2uZo+3nmnpreIxybxs3jK9EQVBYULMsUVC24JFO+heKuzzSb?=
 =?us-ascii?Q?gw2nueLcpIV8VBNb6oPdzWnGKPQlSdQms1hBiJ6KFgJXBpKMk9i7GeA0BkYb?=
 =?us-ascii?Q?yExCIMfS1br5/zu4bVDl5UJNxCfpQTeeKFC2D7/LM/UYp4yhKR8dk1hNc6D+?=
 =?us-ascii?Q?eH80ymoxX4BlVaN76gcaepBebXTNtNZkRQaRTV4vCQp+qUwuc5SQEcre1MEe?=
 =?us-ascii?Q?9s10gVEha1rq9cw2kKyrLlizj/HZ9agcH1zqgvT5Z2AsO7C4z1iuFTmBXB4H?=
 =?us-ascii?Q?MDn6eEs69L5L7XCOhB/tuN8OX7CjmHBe5+chtaUnZ5TtfrQ2YGTv5sqGyt0F?=
 =?us-ascii?Q?lZ8SRcvnEKuDevjmiU7+GIqgl4r5OGMrMfS0shGr5NnBfW/KxCxOwCoF5sQn?=
 =?us-ascii?Q?hgw+NFqaW5RruXHFE2DzlAgrfGr+yOdKENGpI6BqrSxOYuAHJhfn+UglH2yN?=
 =?us-ascii?Q?MvLjTll5BG5LSUp4kvEatjD9IxXKli0w0QZvYBn6JdzTNSf950SbO+ncLrMv?=
 =?us-ascii?Q?1xUdOmf+60f6RP7O30BDH3K4G9YfUxh6w+dWuygFTeG3jvOfiRhdTH36rVhJ?=
 =?us-ascii?Q?lW5YJoDe5hG6fwooe+saQXsYvuRbZkcFR1D6WU6WY92oM4Gz/XhceOFSo44J?=
 =?us-ascii?Q?AZtBGFJhKpNAcQoY15srMakHfcwNr9/nvCqBlCyFjGOZnpEcmsdLYebPnBnO?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OchHyCVD01CgyeuAyCOJsePGiAFRx0hnDkQ896CTMwH1bJmBuqSiN70FErhuObY3mV9YgkthqfWlLLc+zu4NuKKIkChqyED1xFpBCoqn4VT4XG1OooycG+Ae0v+PH7HvzKq+OvPD2Bhe+qULXayW2TyitlIYL9ZdPgPAB4ryzidFdYtQI7xR77wPZQNTzcmo9VycMiZLN2YO7+Ci7ajEFNRywgCWefYSB1ZbxdEhFn5SeLXkDdtwWb71t9omRXwRb8xb4XQiafvoKXvMPT+ruY7n+YyLOmFihJ4pMHO0Tlc7DmnYwNtFbz1g6jP1FCRxauebQzyNhrwVgxWRqYGGjh3jESxoSHlO9nHXxcHBh9XcIA08VUtzkEIIAYWpeUsCWOq/WtD3fh5nAZH9OthdWgwNRN4QLLdyhhdkXoMD0n67xq6RkIl4eq1B3XxrQs9PmIx5+WrPAB/xMtwwSIzc8yCrbdkZR5S0iNmi670mzFzd5N5CubjQSF/4sCkoppzTRTRLokh8/j4iILJO34hOckkB7sI/RDHEloJsJqT0Ax9FaTfU85V0yZz7Dcm+R1ridowrKI9h8rLTq9yeQUjOz/Xeb9NERRfHBcy4FmHWEE85nYR5pcPehYMPluzIzrtU3WSOWL/XoWLT15dm1/J1SxSxAgZa5ckGLD66fbwl04VLnNZvo/MqDRHDe6U9qJurffioF9y8VRiDeV2ea2Qa7i5HjOxFnE8kFPaNvXZuAGGnsFpG1qbk7r1iUltZiOk2lnqTIgdOqabvMvg+kzRGdOSD2LrgFEQ+2Hh9YqDax2V3JRlvlUVBdIgmoLEfG9TAeSETYPJaC1b8bKGgmv7yoKL2kiqgB5UoJegUWeGyAg2M6E6MRNDXRwxas8fGrflq
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dba78d-5f8c-4538-d75d-08dbcfd9a5e0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:56:30.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpYku9GgSy2VkMPW5O+LZ+5XGOjnl4qOowMNEsn5lR2tlqKouHRQrNbfrUF7R578Il3lARjVthv7agD4tvwckw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_11,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180107
X-Proofpoint-GUID: y0cO60_Pe3PNcTY7A_tccGoXTugEZAP-
X-Proofpoint-ORIG-GUID: y0cO60_Pe3PNcTY7A_tccGoXTugEZAP-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 17, 2023 at 05:30:44PM -0400, Benjamin Coddington wrote:
> Expose a per-mount knob in sysfs to set the READDIR requested attributes
> for a non-plus READDIR request.
> 
> For example:
> 
>   echo 0x800 0x800000 0x0 > /sys/fs/nfs/0\:57/v4_readdir_attrs
> 
> .. will revert the client to only request rdattr_error and
> mounted_on_fileid for any non "plus" READDIR, as before the patch
> preceeding this one in this series.  This provides existing installations
> an option to fix a potential performance regression that may occur after
> NFS clients update to request additional default READDIR attributes.
> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/client.c           |  2 +
>  fs/nfs/nfs4client.c       |  4 ++
>  fs/nfs/nfs4proc.c         |  1 +
>  fs/nfs/nfs4xdr.c          |  7 ++--
>  fs/nfs/sysfs.c            | 81 +++++++++++++++++++++++++++++++++++++++
>  include/linux/nfs_fs_sb.h |  1 +
>  include/linux/nfs_xdr.h   |  1 +
>  7 files changed, 93 insertions(+), 4 deletions(-)

Admittedly, it would be much easier for humans to use if the API was
based on the symbolic names of the bits rather than a triplet of raw
hexadecimal values.


> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 44eca51b2808..e9aa1fd4335f 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -922,6 +922,8 @@ void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *sour
>  	target->options = source->options;
>  	target->auth_info = source->auth_info;
>  	target->port = source->port;
> +	memcpy(target->readdir_attrs, source->readdir_attrs,
> +			sizeof(target->readdir_attrs));
>  }
>  EXPORT_SYMBOL_GPL(nfs_server_copy_userdata);
>  
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index 11e3a285594c..3bbfb4244c14 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1115,6 +1115,10 @@ static int nfs4_server_common_setup(struct nfs_server *server,
>  
>  	nfs4_server_set_init_caps(server);
>  
> +	/* Default (non-plus) v4 readdir attributes */
> +	server->readdir_attrs[0] = FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR;
> +	server->readdir_attrs[1] = FATTR4_WORD1_MOUNTED_ON_FILEID;
> +
>  	/* Probe the root fh to retrieve its FSID and filehandle */
>  	error = nfs4_get_rootfh(server, mntfh, auth_probe);
>  	if (error < 0)
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 7016eaadf555..0f0028de7941 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5113,6 +5113,7 @@ static int _nfs4_proc_readdir(struct nfs_readdir_arg *nr_arg,
>  		.pgbase = 0,
>  		.count = nr_arg->page_len,
>  		.plus = nr_arg->plus,
> +		.server = server,
>  	};
>  	struct nfs4_readdir_res res;
>  	struct rpc_message msg = {
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 7200d6f7cd7b..45a9b40b801e 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1601,16 +1601,15 @@ static void encode_read(struct xdr_stream *xdr, const struct nfs_pgio_args *args
>  
>  static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
>  {
> -	uint32_t attrs[3] = {
> -		FATTR4_WORD0_TYPE|FATTR4_WORD0_RDATTR_ERROR,
> -		FATTR4_WORD1_MOUNTED_ON_FILEID,
> -	};
> +	uint32_t attrs[3];
>  	uint32_t dircount = readdir->count;
>  	uint32_t maxcount = readdir->count;
>  	__be32 *p, verf[2];
>  	uint32_t attrlen = 0;
>  	unsigned int i;
>  
> +	memcpy(attrs, readdir->server->readdir_attrs, sizeof(attrs));
> +
>  	if (readdir->plus) {
>  		attrs[0] |= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
>  			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index bf378ecd5d9f..6d4f52bf47b3 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -270,7 +270,82 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	return count;
>  }
>  
> +static ssize_t
> +v4_readdir_attrs_show(struct kobject *kobj, struct kobj_attribute *attr,
> +				char *buf)
> +{
> +	struct nfs_server *server;
> +	server = container_of(kobj, struct nfs_server, kobj);
> +
> +	return sysfs_emit(buf, "0x%x 0x%x 0x%x\n",
> +			server->readdir_attrs[0],
> +			server->readdir_attrs[1],
> +			server->readdir_attrs[2]);
> +}
> +
> +static ssize_t
> +v4_readdir_attrs_store(struct kobject *kobj, struct kobj_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct nfs_server *server;
> +	u32 attrs[3];
> +	char p[36], *v;
> +	size_t token = 0;
> +	int i;
> +
> +	if (count > 36)
> +		return -EINVAL;
> +
> +	v = strncpy(p, buf, count);
> +
> +	for (i = 0; i < 3; i++) {
> +		token += strcspn(v, " ") + 1;
> +		if (token > 34)
> +			return -EINVAL;
> +
> +		p[token - 1] = '\0';
> +		if (kstrtoint(v, 0, &attrs[i]))
> +			return -EINVAL;
> +		v = &p[token];
> +	}
> +
> +	/* Allow only what we decode - see decode_getfattr_attrs() */
> +	if (attrs[0] & ~(FATTR4_WORD0_TYPE |
> +			FATTR4_WORD0_CHANGE |
> +			FATTR4_WORD0_SIZE |
> +			FATTR4_WORD0_FSID |
> +			FATTR4_WORD0_RDATTR_ERROR |
> +			FATTR4_WORD0_FILEHANDLE |
> +			FATTR4_WORD0_FILEID |
> +			FATTR4_WORD0_FS_LOCATIONS) ||
> +		attrs[1] & ~(FATTR4_WORD1_MODE |
> +			FATTR4_WORD1_NUMLINKS |
> +			FATTR4_WORD1_OWNER |
> +			FATTR4_WORD1_OWNER_GROUP |
> +			FATTR4_WORD1_RAWDEV |
> +			FATTR4_WORD1_SPACE_USED |
> +			FATTR4_WORD1_TIME_ACCESS |
> +			FATTR4_WORD1_TIME_METADATA |
> +			FATTR4_WORD1_TIME_MODIFY |
> +			FATTR4_WORD1_MOUNTED_ON_FILEID) ||
> +		attrs[2] & ~(FATTR4_WORD2_MDSTHRESHOLD |
> +			FATTR4_WORD2_SECURITY_LABEL))
> +		return -EINVAL;
> +
> +	server = container_of(kobj, struct nfs_server, kobj);
> +
> +	if (attrs[0])
> +		server->readdir_attrs[0] = attrs[0];
> +	if (attrs[1])
> +		server->readdir_attrs[1] = attrs[1];
> +	if (attrs[2])
> +		server->readdir_attrs[2] = attrs[2];
> +
> +	return count;
> +}
> +
>  static struct kobj_attribute nfs_sysfs_attr_shutdown = __ATTR_RW(shutdown);
> +static struct kobj_attribute nfs_sysfs_attr_v4_readdir_attrs = __ATTR_RW(v4_readdir_attrs);
>  
>  #define RPC_CLIENT_NAME_SIZE 64
>  
> @@ -325,6 +400,12 @@ void nfs_sysfs_add_server(struct nfs_server *server)
>  	if (ret < 0)
>  		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
>  			server->s_sysfs_id, ret);
> +
> +	ret = sysfs_create_file_ns(&server->kobj, &nfs_sysfs_attr_v4_readdir_attrs.attr,
> +				nfs_netns_server_namespace(&server->kobj));
> +	if (ret < 0)
> +		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
> +			server->s_sysfs_id, ret);
>  }
>  EXPORT_SYMBOL_GPL(nfs_sysfs_add_server);
>  
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index cd628c4b011e..db87261b7cd7 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -219,6 +219,7 @@ struct nfs_server {
>  						   of change attribute, size, ctime
>  						   and mtime attributes supported by
>  						   the server */
> +	u32			readdir_attrs[3]; /* V4 tuneable default readdir attrs */
>  	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
>  						   that are supported on this
>  						   filesystem */
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 12bbb5c63664..e05d861b1788 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1142,6 +1142,7 @@ struct nfs4_readdir_arg {
>  	struct page **			pages;	/* zero-copy data */
>  	unsigned int			pgbase;	/* zero-copy data */
>  	const u32 *			bitmask;
> +	const struct nfs_server		*server;
>  	bool				plus;
>  };
>  
> -- 
> 2.41.0
> 

-- 
Chuck Lever

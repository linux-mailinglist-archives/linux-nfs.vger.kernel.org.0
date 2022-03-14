Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29D14D8A5A
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 18:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbiCNRFT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiCNRFS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 13:05:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E29F13E3A;
        Mon, 14 Mar 2022 10:04:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EFSa8l011145;
        Mon, 14 Mar 2022 17:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=/INiDw5eNXS/dhrc+mkjzpUgA0x/2DQgrHiKH0H/HRo=;
 b=I3KYcDXzjhqmuRsT6RYTW09v2ImyjeXvvaUcguEgdEbl1Waou6pZ1iWJtFTnhbvGA9dj
 UAakxDSCwTpGrffFNxGgEBXEY/Od0NM18Y18iHbem7cnyn4/XpEj8sD3O9p1c7+iN6cU
 E4a9SAIviEaYa0w2exYi0n12TFKF/r/4Ibqa380y7nE56V3Ki/tqccNbgu2RTGGl3GFW
 jnTHNh2aBZqfLGwxtSJUpxmhSFQx/4RaQBX1jGF6k4MxjoPv3g/Y28j7pZroDygHm1xK
 DeXyrDlxf2F2u+hlL16kT/9jJC5VFTUv4hnRSkQSr0zhQwJFtLiJWKn+eINqrZ3lutye Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rgv19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 17:03:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EGpund189360;
        Mon, 14 Mar 2022 17:03:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3030.oracle.com with ESMTP id 3et64t4ag5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 17:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdQyUpYUKFv5OaELZv58Yzpv8cNKnXen073FhsxBMxlc2B5gVmiXB5VTz6lzbdhIKmXOoyeZIGZTckZj52/Q80e2xrdh9FS78Y4eWOOnro9S1/b6XEbsVt25ZI0yNoF0ECAG/WKk4drSniVNT2Sa1KP1zsmStaAeehtYUtOF9e1yO6cDMN5CP95mCyKuoOt+e+AX3A1IuJPdC+1+kgYajZCslV20x8L3ufXNA61ZPTuoXcDwFG7XgRyxHVbB8m50AsXlT4cTjRWkFf48He7rE1rhITuFEjcSDykNn9AH6xds4NqCnUtxS0hjv6w0jMUb7lcebrZUUn+E/sfnX0Wdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/INiDw5eNXS/dhrc+mkjzpUgA0x/2DQgrHiKH0H/HRo=;
 b=C8rkDyoTxSB2J2xQ+N9jo4ZNn+20WxEJ1+G0g7cxQ6NirE6oBT0zomGYR2PiucQxKphlF1p7rr9h29m4xltVM4t4g2uMkwcvduJBg8ABZ+vqQLJXmflgDO3j7eTQcYJARlIxJ2OzQKuFEQexaNlw8a+xjG8Re0XriiMVueyadTSnatvIR5R+J6EM9MyYxThc6ekkk5uFkCcfFiFK2zHUucVqD309PXd/UTbo/JNFjlY4CkD/iL5lztttzCGStxtvcRvdExxJsbuBLuzsoS8pMWURmNp8N5PfZrvzzLnonVvN0NFyAI8kR4Bqo8rHb/ggOJmfRnUtoYsyJr6TRJjvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/INiDw5eNXS/dhrc+mkjzpUgA0x/2DQgrHiKH0H/HRo=;
 b=uhqWIc9GfNYPHgitD5BjSMTM0Ya4HY4Qxnxp+fYA+Cc0DHMzWKcpTOzC9TuolU6Z4cRkuE1evbfjHM+GQ60xVMBSaz+eLncOjzPlCBCgk3bHtZq7CfYpqt9SGKvq48gf8o101NH5qdHHhzfo23TuiLIieE5vqFYyWz1XPtZ3JGM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4910.namprd10.prod.outlook.com
 (2603:10b6:5:3a4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 17:03:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Mon, 14 Mar 2022
 17:03:56 +0000
Date:   Mon, 14 Mar 2022 20:03:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] NFSD: prevent integer overflow on 32 bit systems
Message-ID: <20220314170344.GT3315@kadam>
References: <20220314140958.GE30883@kili>
 <251A4166-DCCD-4C84-9819-F350D17A7298@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <251A4166-DCCD-4C84-9819-F350D17A7298@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0129.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b848be7-e172-4885-f1af-08da05dc9fad
X-MS-TrafficTypeDiagnostic: DS7PR10MB4910:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB4910CC3D6D5F92AEF2759CD28E0F9@DS7PR10MB4910.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFkU7WhSUr+NRe8RXWIcHIcvZtgU5Ya5qEIp3Tt4q7sB1oAGbvbdaam5e6ZtSWT/VpzVHcguLnkAgCmDl17j+CJhBE9+ROpuGE9VpaSIOIe6rMOyLUIE9b8hr8oOoBR3ISvF7YWTgysn200hLRFHoa1WMOz+AhqbAb23/qS1/sE0AqAKExszuyGizgf2ssZZjmQ4fAOzzVG0aDkE6N6Yw0JPprIDIe5YhcJy6WHKxs7tgoS6PqAmX3uJJ6AX83+O6EgW3Vj8M9r7Mb1p3mb6MMYsqsgdewZuCSfycME0Z3zneAoQ17gXFxexDnK4vLRcaM1thXm5YUyODcu+vlBeG32qrRBgerg9oEOKCfjqIdeCKZCz/d8G0ArMaE6q1RjaYzYTJNcyK0LqbYjNXWMRirwvH94EO484OcOpNpPNI80D1I2Lw2JJanYFYBbQklD1lEHwZMtPGqsQ7QJcMVmjEc6zMFWRy/p/GiPNP+LjBFru9UqufVFu0feiU5UDsTNrPBQ7V7H79WFNt7I8w3X/+Pbfgl7bXdFJnyrkz8KabLtqL1nnMSJQ9ssfBXQIRo93slFcjEIJky+xNR0TPe4Get4Kqu0pJ0is26qrdLYZ0z1S3Qbqv6f/9Rxf8DL3zeuCgw6iGRWNc0r2MqPyjQVMv3oGyGk6dp4MskWrGNzqDR88A7HpEI1Omz4hv3LateATpwTuy2xXe6MOa9J105d6bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(6636002)(316002)(33656002)(38100700002)(38350700002)(6486002)(54906003)(5660300002)(2906002)(8936002)(6862004)(4326008)(8676002)(66556008)(66476007)(66946007)(44832011)(107886003)(1076003)(52116002)(508600001)(6512007)(6666004)(6506007)(26005)(33716001)(53546011)(186003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UWagCj3tMm/HZjYsOYMpV3AWEfl/sRqW29A+wK4VbJ87gpDlyCm8c0VPpE+u?=
 =?us-ascii?Q?xScnq10fs+Wre/RNyfoS1WS6xCdTjwkfw+c3/qMDuf4eZo24A7vTn2ov205A?=
 =?us-ascii?Q?D/R0InEpUjmvrquEsrkg8vJskxKV7d3KJdZ4BJd2+y7tEZpRYHWf0wm6duQO?=
 =?us-ascii?Q?TuqNdAA8961cAy8tW6ICK2xeeFZsOjWVbyxBzM2I4Dw1jil3etdRsHcrwta/?=
 =?us-ascii?Q?VmrajR3UQn8ppvNgcJuPY/XNW0UY3ES7zpaWmKENASlh2l+cDhcxpEwFct+O?=
 =?us-ascii?Q?mvsoikETH75Y7fHOKot05R7Enob6vgfRA3SFITYQKq4WIB3ZorzDcZ40RK+Q?=
 =?us-ascii?Q?UZn2GD0w0/OlyCPe8bglLrVSxmp9xu14H/5Wlelq6ihLM8Bd2M/zz93gEXzP?=
 =?us-ascii?Q?l/2qpyQFpZ6cnkNpmeK/z7fZQ50V+wedVNzrNwnxufgkZFjy59Glv3AosJkl?=
 =?us-ascii?Q?trl8P1qNzLcuIF4fl1DnJgJvlqHqidHZJNHGsYB31wRWkYuWhi1A6rvhNqx4?=
 =?us-ascii?Q?HNX4FPMEQU7HaqgkG4I1vbk29h2f1cmIY8/hQvwMkcfXdJdoEdtFRIO5XWx6?=
 =?us-ascii?Q?BfgR9gzLpxBi+BZJiHBqInhl2r/RwA08AFOVIRXmHmn4N1Q49cOo7gx2kJXL?=
 =?us-ascii?Q?DT95Z3weGE/mCQEjVEpwm+n+5LBPKktG/2dcqi9ShdUR4SbxUIxm9xOXkbR0?=
 =?us-ascii?Q?qnqij3gfOLrQbnGBLYIHVdZAkNaLXbGFt0lnxUmitDJBO1RkXSUzYk7jyLHq?=
 =?us-ascii?Q?srAYhQkU6DwpPWL8bRkIbdYbifjs+DVECsKKvYYW/NZ22e7uS8IvS5xQeshm?=
 =?us-ascii?Q?wedkgEVetmDB0oNOp9HXKMhOpiBLUVaDHLHnWSnOUoqBWnjY6GMghwdYX9rA?=
 =?us-ascii?Q?Okl3Fo24+3esRjU14W/mFVXR2nkMqWNhiaXzDu0x6vVECg1ePPw6n9YHLn5s?=
 =?us-ascii?Q?Mu9oMrfxFUYFwQ5v2K38gizn5MFvhTF7m433tpNwhfP7hg0bTvinw0xTkjZa?=
 =?us-ascii?Q?UuNQgj+ZzM550bxtktdop/kOhYPGnHbjDSmfrMWvHR3TOt9vGNP+z4yuWaPT?=
 =?us-ascii?Q?zSkllQS4Q555DIJyswakSmzdktSZQsgDI78LZEezAkI6gWAtVIsg9E+SCXEp?=
 =?us-ascii?Q?cE/CuhtBUyBG5qLfRlyNEZ/MhfPc/3RTXZECg49rPSX86AQByC/umzQJ7JTr?=
 =?us-ascii?Q?G7Fad3LyFLJQvIMppr0ZLeUbFxUPdFR81uAsuMAXgCp8BP8fdEjoy7J1jQbb?=
 =?us-ascii?Q?tw1xrgiNslXEgrTZRvuwT/So1dJBe9ltO1jup0x7SSfDaAEI8YuXVh8OfqQ7?=
 =?us-ascii?Q?HFG9u5JRlWwUS1+eHAeqMR41nZsvo68BWK9Tpr1NiTkuKPLoQfpRSir9sCdP?=
 =?us-ascii?Q?dxVKNTZtdLhlul7O39bNTbKeoOkT0tsXWn0bpfnQQEKBBuPnz5cpwJ8Umvf0?=
 =?us-ascii?Q?P/NoMYTsGNsAPrbtmaAS1j7E3DhO5DMWmDb8hqqOFI3uErQ91Xclrg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b848be7-e172-4885-f1af-08da05dc9fad
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 17:03:55.9860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkv196DMR0uAiTPXwaPjkaQvNkogwSjx0SD+aYp+YgsgPnjnADmprFaQqBifVbMY1sFiPyiyeRQaWHAwiTdrdG7jtVzXaUxIGfX4nedjBY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4910
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203140104
X-Proofpoint-ORIG-GUID: E4ioihhRJ10LZqnzlAiS__vMOoK5CJjB
X-Proofpoint-GUID: E4ioihhRJ10LZqnzlAiS__vMOoK5CJjB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 14, 2022 at 05:45:59PM +0300, Chuck Lever III wrote:
> Hi Dan-
> 
> > On Mar 14, 2022, at 10:09 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > On a 32 bit system, the "len * sizeof(*p)" operation can have an
> > integer overflow.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > It's hard to pick a Fixes tag for this...  The temptation is to say:
> > Fixes: 37c88763def8 ("NFSv4; Clean up XDR encoding of type bitmap4")
> > But there were integer overflows in the code before that as well.
> > 
> > include/linux/sunrpc/xdr.h | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> > index b519609af1d0..61b92e6b9813 100644
> > --- a/include/linux/sunrpc/xdr.h
> > +++ b/include/linux/sunrpc/xdr.h
> > @@ -731,6 +731,8 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
> > 
> > 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
> > 		return -EBADMSG;
> > +	if (len > ULONG_MAX / sizeof(*p))
> > +		return -EBADMSG;
> 
> IIUC xdr_inline_decode() returns NULL if the value of
> "len * sizeof(p)" is larger than the remaining XDR buffer
> size. I don't believe this extra check is necessary.
> 

Yes, but because of the integer overflow then "len * sizeof(*p))" will
be a very reasonable small number.

regards,
dan carpenter

> 
> > 	p = xdr_inline_decode(xdr, len * sizeof(*p));
> > 	if (unlikely(!p))
> > 		return -EBADMSG;
> > -- 
> > 2.20.1
> > 
> 
> --
> Chuck Lever
> 
> 

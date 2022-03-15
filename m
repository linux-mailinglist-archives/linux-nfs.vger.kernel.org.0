Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F5F4D97FC
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 10:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346817AbiCOJqz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346827AbiCOJqt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 05:46:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A854F454;
        Tue, 15 Mar 2022 02:45:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F8OV4R008016;
        Tue, 15 Mar 2022 09:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hohYl0jw3n0HJHKwUOGPY3+MOaoQB8bKjmuPCRBHf4w=;
 b=EiSqvvkZLWadbTQKzulHgO5txVm9Iyp6ZQwD1ICFQxl+gEef5NCs1+EK5ITQBgVDhCfA
 waeSssBDux1uzGBTojSLeohgWGQets/UnDjUe/HKEW8ytIJB9gw958JXMCJLIUO1XLTT
 pi1pnWWMBKbyMjjQ0HC8w6RuVHqLfeKziINR5lOq5x8nKGnUg08eUXv5Y0BCWged4qIz
 YzslHOfyqhMXp7iTNkIKHJ6OVIfvYl89qUcqAnodyYOsBe9k13SDFbyGOJ7oPiLFNTlc
 iVUKpTX4jO0lD3uTxvl2QwMxKjfNtoJMNJv74JnHZt7KUQxAQGRKwZ4Isl+NI+ToWhmR Lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6jp2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 09:45:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F9iH7B184990;
        Tue, 15 Mar 2022 09:45:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3et657ewps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 09:45:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahbStMAUmJbZsoaEi0sjLQoqfFiYmcI1C4GKWveOY27V/hIlf8bd9BLSDKRnx73WYZZdnF5H0TvMTMBLAQ8j+kbHjss8fzCA1+fxjmyl/VBzAsnSZlcnAlRULDYVy4/yQbFgXWpp02dfDK3jWgXYlG5BRQnsIiPnXMiQQvkHIG+EUA5R2Byu7I9yIxWfqdNly8Q3eZqsTnkRa6g97jJJMyAeen5QSDniSCkQRoOdMsRYlw1UnpiPokmvEceDcvgPtkm9iuanp6VEGNvTF5speY2TzQHRWx2EEfJmgWtURTGft88gZK4cxgYOVboMBdMuGt+l64D1Qi68ew3yRqVOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hohYl0jw3n0HJHKwUOGPY3+MOaoQB8bKjmuPCRBHf4w=;
 b=CnSQM3dqGXvnE2Bx4oRm67C2PJAo0eGmJTmGnN7CrChmf1NiUUO8qGdNWQEJYWfD9anGjDi7hsAZKnmSODuDQLBJYtBuPldgcd8jmtYxE5fpJq6SJwfEDImnuS8nkX0bkga/CqdwVaJ8UpDFCAkLVoyNp66CJF6/9K/zNLHAULtpEtSBm73ONU9NGFDCORyKmjZqDA+3fQQm6GYYdHZ7XGqUEsNg/ZUCAIphmOGUAIyenTIv5bm8LsRRmbzGR/8YkAaYRrJF5NA/UtX7oTxQSPR+u663tDrWjPMJF4fUJqF4EWzWXlZTE4mODwhJN7c9b7LVKwBkP6Vj7qiytGDJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hohYl0jw3n0HJHKwUOGPY3+MOaoQB8bKjmuPCRBHf4w=;
 b=zzu3rJvCEzoaJw8oP1lfSMj7qSVboxAsE1Xi7lSRgziPvQEA+RfMzVsdLL/aQAIDsbjL9rrcyEpRh7uwaNlXb4X0gChnjahUvSGU3o/+WFpD+MLYvy+zXKs3AMgU2LOEsLQLaOi75/gzRQGYnRrHqoficubgx2WrvvpLjpTvQOQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2323.namprd10.prod.outlook.com
 (2603:10b6:405:33::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 09:45:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 09:45:23 +0000
Date:   Tue, 15 Mar 2022 12:45:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] NFSD: check for negative "len" values in
 nfssvc_decode_writeargs()
Message-ID: <20220315094507.GW3315@kadam>
References: <20220314140635.GD30883@kili>
 <6F04F280-5267-4D12-8053-2074703DBE6B@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F04F280-5267-4D12-8053-2074703DBE6B@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f834abc-d0d9-438c-3db0-08da066886bf
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2323:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB23231B029D34D78B75ED4C378E109@BN6PR1001MB2323.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Zc+0JjMy/H2GtVok4xBOC2Bvz18ek4g8bjtNh/XDmJ+7w77vkfskuK+IKg6Ofb0y6JLNcpmUB0I3LiNAd63k3T7sscSI0QOo4yZN47yud5Fd4qRje2ecVwwCQCd0YUyIi+07K4UXeY1EuHuMvW9CG3e+SMZIxCawP5c2gaHCQxeKaPCEadoDceUMxVRmEgGCk2ugx3O36qi27bgTuW1YVI6+6fgjlJ/IkXSdoP/hWEVrIEi0XrURYR2jkzhVhipg8flrhz5hY7fRYEaSKyYSV7S0nDWb/6N3s30FfYDGPePBQiPl4zsNo6LhuTK/DVGLUj/zWEiBipnQEK6BIMduvkr537Y0DmjdrzEr3GkbjprsszHrhKlkGdTFAQ5RDKg10hK1jdhOTfL6Q3Xpsx4Dhv0mWgZ5SBbP0grRBzsPkksLtL7IzuK08ILU13VH/ImuGAyFvD2B2jTR4c0gBMj/F0JMgL2qn74cJTScX058ow6dTFzyowoWzjAvq2j9pekXlXEHxPgidVYVPp+r+iyNQbhj46UCs4Y9WZmSJiXSzeqz9JBcYyXLAj8eBvbeK/pt0sPxAKdL3uvO4ETMvhwh9RjV/F7z44G6cEE4LKKjkJQds9bqqijEGNtx0LU19BPqqMHEuZSecvo/SmnjXWHP8XE37wMigtUGpi2utOrW2Go+URLFjoTy2L6gQFim3TbCi6OYA9/buSB6KlWMSPYhleX87yNIdTXUtLdeCuD8R3WZNuEAnuMtXiNXl7oYhnm/4fdMkYiFOh9hoFh/0tx6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(26005)(1076003)(107886003)(38100700002)(38350700002)(86362001)(966005)(4744005)(6862004)(4326008)(8676002)(54906003)(44832011)(316002)(450100002)(33716001)(5660300002)(6636002)(66476007)(66946007)(66556008)(6506007)(6512007)(6666004)(53546011)(9686003)(2906002)(52116002)(8936002)(6486002)(33656002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9OnCOuepO45+fGI/0X3RppSuz+sNDY8oKQV+2MmpmhYZProHybaPYj/DRcLa?=
 =?us-ascii?Q?dOzFjWQkcSR9p+tqGWpKNYA/WsBCvevCkrE2AQfu/VYMHnP/93lH8Btq16ix?=
 =?us-ascii?Q?IhL/Sw9qL49tlmVF+rxgnwTV3+Y8qJUKxQm2fFERjC4nqrCnuxMJxzReZ9tW?=
 =?us-ascii?Q?L9fYBsnFCI8zryY/S0Nt4ylzTfX9mw/xVAMnhqKbjuGr/wdVmTITkQWL5N66?=
 =?us-ascii?Q?7utFlp1rDjizr0xrv2gP9Wwslt96ORV94HhRhW0h3hHfQ9tAeVILIH9vPWDg?=
 =?us-ascii?Q?okJvchQmltfrHYAkVHWyproGjo1TZq8ayDNulOiCxs/RgdpiHmTQrhOb9aSv?=
 =?us-ascii?Q?335jJpr2swyRjkFhhBEhlo1NfcDHWZQIuCE+DwoCjWIh8MLYOjUMfjah0h0r?=
 =?us-ascii?Q?+MpJGvBkr8r7efFPsBzuZrZTBHI0lYCT9NkhmwYu7xpQ5WzhK3jYF9I+0bGc?=
 =?us-ascii?Q?ihAfgvrs1ChL57TWcdK0EFwg6YnF/n8+NXnnxppnAkNn692G8+HwCgKbZsa5?=
 =?us-ascii?Q?JFGB/2aTOq5Sr+lFRHQrYTBSId+ABQy9SkHcxoacUNKmBen/IWlihj2o2Qoo?=
 =?us-ascii?Q?tCUuQDzvCNH/eBlxL0tR5NUJp+FJSpDcNOtzOcj+l8Ln0saXgNctLMP5c/JA?=
 =?us-ascii?Q?YeujeLerjSK/ZtQb2vUEhGPLdaeVobLTA2uc5W3veQLndx7/ZB9ZPUXjhPJG?=
 =?us-ascii?Q?dKpka8v4/NRSGxEMtEIJ/F+rclxvx2MrIy5ovmvRYcrLOOSmv1srRvZwgax0?=
 =?us-ascii?Q?URjLc2UErmsjSKViBpgii+WaIxGPJxEQ8BSAYtf7tBBoR25meSEETHAAFVPk?=
 =?us-ascii?Q?RJHFgFo1WFXJmYeX+DSK8+1kFWkpy+I/W1ak1tvGOB2JV0rQF8e2L70fhxP1?=
 =?us-ascii?Q?hr8nA1bBPHjbEQD4aEuBB6Bto8/m0fc6GgAq7sX+j97r+DTl8p8aly0mT077?=
 =?us-ascii?Q?jcA0phZEsC8RwqVUprrtp/i+qaXh29Kq8Yfpylusywo3mcwZz67XN7ZMfZQy?=
 =?us-ascii?Q?6F4JCzR291f4TkWfJNPghEeLHMWbbm2z4cQ7LeRhkGNg2dx50QKh1xmt2dDZ?=
 =?us-ascii?Q?ugA0iKznqkrgyq6jJ54ESmW11kTKRfTa8iiM/5nT+efQZVJCjttExkLiGu2s?=
 =?us-ascii?Q?8Q2iiX+BbzYzdXUQasZPjdiPS8BU6B+wBdsLJB8Any86F/sv2y1JRvivD9gY?=
 =?us-ascii?Q?LvDpuZoHt2lgJ0RjbUKQQi/FbWLzgpmf7xmoMd3rCtS+LZ9DPtGnHyk+FFE5?=
 =?us-ascii?Q?weQ0iNIKhpxaw+DlAnFdHS/PpBzo/ujy9puXgDIg+Z1DlQhfVSuYeNu1+Fjw?=
 =?us-ascii?Q?yyVJEl9KpfgWC5iVSxzXUgmWx3WCAl4oBnBmE9FYJZBKs0D+/R3vLDZQP4/m?=
 =?us-ascii?Q?g0H8FvwFsrCBCWuiACb7mweArDXFQ2XZYEtxEGNfjK1IJ83H2PiFmpZc8uh+?=
 =?us-ascii?Q?4tSW8Rj6y4CToJ/C6OCa4fqPBSMfK+ifOVB0K+lNkxizr2Mzklae9w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f834abc-d0d9-438c-3db0-08da066886bf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 09:45:23.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLSNw6Fmz0wYgBYK35/ktJPvRgc4iC16s0/ZCWMCB++34N/G+IhQoqCbW4XFyEggjA0fzd8LuLOY9Qq/MnTiEc2GlZPwfbUYNwaTRHBlOMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2323
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150063
X-Proofpoint-GUID: jvJaHJdsHyrf-tbB32XOZTggsAx2mibW
X-Proofpoint-ORIG-GUID: jvJaHJdsHyrf-tbB32XOZTggsAx2mibW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 14, 2022 at 05:42:58PM +0300, Chuck Lever III wrote:
> Hi Dan-
> 
> > On Mar 14, 2022, at 10:06 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > This code checks the upper bound of "len" but it needs to check for
> > negative values as well.
> 
> It doesn't check because nfsd3_writeargs::len is a __u32,
> and the NFSv2 code here was copied from that assuming that
> nfsd_writeargs::len had the same signage. This is because...
> 
> https://datatracker.ietf.org/doc/html/rfc1832#section-3.13 says
> that the count field in a variable-length array is supposed to
> be unsigned.
> 
> Thus IMO nfsd_writeargs::len should be changed to __u32
> instead of adding the extra negativity check.
> 
> If you resend, make sure the format specifier in the dprintk()
> at the top of nfsd_proc_write() is adjusted accordingly.

Thanks for this tip.  It's weird that GCC doesn't complain if you don't
make this change to the printk.  :/

regards,
dan carpenter


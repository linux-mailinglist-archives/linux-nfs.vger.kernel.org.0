Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F377DBCF1
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 16:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjJ3Pwv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 11:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjJ3Pwu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 11:52:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C905ADD
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 08:52:47 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDLcmo011230;
        Mon, 30 Oct 2023 15:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=spv18/BSMTTtp54wnC4rpeM2bPQSxFPFHNdRzbTbxqU=;
 b=tUhgw83N+uj6G77UCgUanlIciAdRLhLglVJwmUl+2eqTHNBagpt+2Zw7WJLxIKaGBYCN
 tdL94mOFCpGpo2KFASsrfB7LeLxenwYq1HGDqBjrTR5muF4XDfqjJHDTQEgMAYuwZWYL
 M6adic9hZGRMYskJBBARoGqDfkWTNwtbMlPOmvUyYD+pHgFOSekZyBBt9UuYlFC/URvU
 +ERWI8qC4lGSxCg49K2SgAulTJaoo00YYFS9PhrynJ9mIqRr9WvMhyndnWCa2iDLgRTd
 Nzf61pEyVogGnTf5K4m/XmwRVjrn6Vw4N2scwF3xtznad2ptS++O7UUWVKuFA5YQZN2C zQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7bu42v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 15:52:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UFbRtE009075;
        Mon, 30 Oct 2023 15:52:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x4an82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 15:52:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5QmEhFSdIfAJY/H1s5tEtpnBvqJCTY7G5vUov3bm63lNCgCfVvOvWvyJBYD1ao8sNo6Yq6wl1IyoF+NRH0Fos/lHbMwALmzpF8OQo2/00Tf1RJwnIrl3HtGDIwXPjfRO2ACFU5OSAaKOwbmil0V1Bo2G6FRuWOsyHd+Yjyn6h3qkI85XEGAxXoc0V5lNbCBUKuEV+JAgNBPek7T/fKt7GPvsmAqGM41RShQ5DwpdCTmwWP8lnDo8jIICBRdIWDRALhGNaebuAv1GEzCVvxKqyspgDlZuyZIz6QzPZDNDqu6T03ITeu1qjElTfv91HkHoD9Qylmo1rBn4NGlzFHmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spv18/BSMTTtp54wnC4rpeM2bPQSxFPFHNdRzbTbxqU=;
 b=Zdck6uYLVFGGb5Zda3zVFP0HMEOzEG/DuwHbCqeB3SPVWZ3ycs+oRdRP3kDTDJouCFOAq7L4Ja3vrS6mvhdDxQhR3YQV2LWRXDe4lJFR9oXLfVztLf1X9c/QrHgauzn5Wl1+WzBaisBTgahKYzGwqYKor0Yb+YBHQB+5X3eFp56AsCJY8khWBiqBZFilxL10nPiBRR/QyVXwT2sXd2CnZQy45gpZ/hKmNuGJxiIeUqlANAOeah/Chgxu38A4WzVjTv8YKtSWIysBENTNLlSF2wO5VnfECa/sFiFLlZKh5PNE7MgmbNu22zZPbqd18rRg5iZRX9s76Ix5kE2MkG04lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spv18/BSMTTtp54wnC4rpeM2bPQSxFPFHNdRzbTbxqU=;
 b=lIJ6Ltd+zWglZhZvhbzwDCVnZgPVpdG3Un7943AvpG+j4ZYQx40ZGcd8H8eD3SRBkw5HT1fKV01eZ8Tl05oMGtA5PmCdD3GrOJXQge+z+dGJREigQUvZLX9Mya8UCgUJ22cmpNFkwSs3Q8Uu1dkqNi+pG2A5qBR6gJ0WJT7ZxOc=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CY8PR10MB6467.namprd10.prod.outlook.com (2603:10b6:930:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Mon, 30 Oct
 2023 15:52:36 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::3a93:ba27:cbea:c6d4%4]) with mapi id 15.20.6933.019; Mon, 30 Oct 2023
 15:52:36 +0000
Date:   Mon, 30 Oct 2023 11:52:31 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 1/5] nfsd: call nfsd_last_thread() before final nfsd_put()
Message-ID: <ZT/RPxpps2UcjzSh@tissot.1015granger.net>
References: <20231030011247.9794-1-neilb@suse.de>
 <20231030011247.9794-2-neilb@suse.de>
 <eb7fe40bc430891519a038434d41fb9ca6557526.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb7fe40bc430891519a038434d41fb9ca6557526.camel@kernel.org>
X-ClientProxiedBy: BYAPR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:a03:117::26) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CY8PR10MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c939b6-3c02-434a-9dbf-08dbd9603c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eo0d5kAdeBIwxeeM4AABziR347jNtI7j02TCVyDQZgcktPtDtkYvg/2TxT3E0MgpLF/3sIkmIEcwn5xwGmJMFkqH6bdPhxs0s5Rv8vli0WgbdE+T+wpoITYkMHds4d4qDqlxgALOStFbvtwXs4WBzkiesXkzrQP1iH8D6YFsEdQOWp8ceJsxYnZX+Xq+0pX0EYt+k+v+BW9twDmA8Wg80PwFdhnduhm4zuIn4TgLPO9QkgRC+rDNv5DjffadiUkaCLV6jp1gtmRr3aL2KJJVKbc8m4VAd/I22KGsiqmNpzA8OkumFvQ8hErR+8i2vcyVrSRBYPD5MOoe6WW7v5bVv31DsHJiMFPijQqE3eZh4EkuiokDSI03HJpRYj86iKxJ6Qi5tlFzlUHFrWA7LG48xvMs48362JscUsNx+MB1c3gbaA+aMg5AswE2TFknE/pcez62Qk5bSJ5I8BNCcB2MgoLmUcqv5tXMgeO0wqWuCEQOZve6MlkA3yoPHQdd0ra8ULgNYN7POg+kMU4Ec6Y0HrskHFQDDeyA5nkEUtFvFpZ8SVp/qCk490+EkhpdYqhX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(316002)(2906002)(6916009)(4001150100001)(5660300002)(44832011)(66556008)(26005)(41300700001)(8676002)(4326008)(83380400001)(8936002)(38100700002)(9686003)(66476007)(6512007)(6666004)(66946007)(6506007)(478600001)(54906003)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b+4Nk2X92e9LNvtZtpiaM7gtFov5v1b1NFQquBT1nt/5OLFOmA8/Qh/EfTM5?=
 =?us-ascii?Q?oXlXPCrRymMQWsXcRmt1H4z8svRqodUC5cKlTQUE7Y+iQr8qys6h/Va+nn+C?=
 =?us-ascii?Q?XyWpNzTqevRYgG+HPglZyV1EOqHCknTNudlUBu/vvDHYPttZmB/D/9qU73R5?=
 =?us-ascii?Q?SXILnQl+z0YLcuKLRfGDR2v07Ifkck7zTC6z4K1ZA9+fCihlKedw5gkfXobS?=
 =?us-ascii?Q?F5wLrWPi09zR98PequQIZnsRTJ2MelyZAiA7DePygxkZCizKy3UErZwOBUti?=
 =?us-ascii?Q?QhW28xVGWsvBevZxHrC6e+Gz4aAq7VXECzjVkLWMDmPLfZgPVqzBs29OLljq?=
 =?us-ascii?Q?Vh+UlEo0WKyVDy0UgTBHLgitU6Q8Uxq7gLpZL0V5bfwaVze2uA3f2eFi2H8j?=
 =?us-ascii?Q?DPIP2gk05CACrDf3RL5/SAB8kc/OC8PPLziC1lIQp7pSBVJCl45HDyFK8pNI?=
 =?us-ascii?Q?MozedtVArv9lXzJaCv1hQyIimaodQxHgKWRq5keK8c26Ny7JF9VGfjA1qlmv?=
 =?us-ascii?Q?G0qnrNy3wGMLtohHJImmUH7xyopqQHrbWAue4FhjvaIqgKYLB76pTtOcqsXY?=
 =?us-ascii?Q?GSBqQi4TKD1F88Ej/cjxGh6AuJ+C2emiRz8AeiM96Vuvo5GpLS+fd+2CsKJx?=
 =?us-ascii?Q?x7FSOWtZs7AN0ldrTl2vpzWG1xUk7j6GkqaNxQrLF67yRsKbCM5xmtVWNdlp?=
 =?us-ascii?Q?F8x4rjHBbliq7S9PFlnLfSjtEvXqBEoYgGGslaMLrTwhxxgIrzw2wqvOlVBd?=
 =?us-ascii?Q?FHIGUKjiGlFkZfZZGZ/xUoMLNCr0Lq2imrk+2gBjuBATI7JzeNJZ+eS1IC+f?=
 =?us-ascii?Q?N/cLoPddHg63WGvMTHrAMdKZnEaJECMsmSnACv8lrvc4JDDBTF37bCsMg7dj?=
 =?us-ascii?Q?7j/Q3QUc0uCul5AyqZayN3/zWNYbssNhxw9CpfnhWeVc6MOTH6v5cA/F2WRa?=
 =?us-ascii?Q?yd9pCz4xbo0oEy1WSDngRLuYvIFfAStCF3HfFpt+/65Cnk17jXJQyBpZMaII?=
 =?us-ascii?Q?2LI6tlJIyQekueUT6U30LVB2t9MYLEitCQOlR2YbQXwEQ/YF6Q6D5G8Ugo0l?=
 =?us-ascii?Q?kLbTs740qpW7szXbT8zoSiAfqbqNb+CZJEHo9++oRZGGRGp9aTJ0KBTYDkpW?=
 =?us-ascii?Q?8aUz7pTDbjlywH9/LdqQYboL7WhybvJ/23A8dDDGLQT0CK+KxltV5eiXkKC6?=
 =?us-ascii?Q?ni/EK6N5iwEO3+XHfi0zP45R/cZCpgLBMirWlaNZdbqOYHKrdKvNPfPZ9BCz?=
 =?us-ascii?Q?wPzmKv8Ab+AhNbtpRLu5SBcO64a3h9MWC0cl6IrTvudJiyzpXoNXMX80taos?=
 =?us-ascii?Q?AYHWIPzatUK059ko0YqQDXyOnDXw8R8JckLQcrkZmu90cBpT8+tKhJSwH0Fk?=
 =?us-ascii?Q?PmXoeQduSUODE7Fy9MgEfS3pAIEMmtvnzdjHeF/PlSrHxfhZNjc4RUmkqgrQ?=
 =?us-ascii?Q?s4qm3gNFCa5ygBXFmRvyL1xok1rKB1KyHZQP4IctoBRWrhxnnU4KIBh0vZUN?=
 =?us-ascii?Q?yWinETYnfLxUkFKDdHR+Rj1cJj8xkjUzxh/MPurM036MCYQJ5h/RpGxLZna5?=
 =?us-ascii?Q?uAt/boiU2sc/Cdc7GGZSwSo8yjGYaryu14cl+RSV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gWcW/hZ2/0nkPURtHJtRYScKkM2oFag+DRHMGenLfgzY1CxTlcVjp0maCsOjIK+wuq7WGH5zCq4Dsn7iWJSDLIzbrk8elWd0VqlSEC+mukhHGrBI+bEtOmTxm2lfDUCFYJXiFqe0AK/wm8GdSq3U9pp44rthITXaV8eckaprn2qcXv0ItSzy63kXGv0zEGV3WPpAVXbVwTTROWc48JLvt9G7kjm8uQUSLjSPFKhIuxmsKtljuTJRhsHjfy+qESYVrY/XAybHGSm0BgAlqZL6DCsWltNibyDx/nLOFKVtdTJwj/m9CYF1fHcc+wrwRdq+bivWIGARMTjTTKOHxolp8vv80gh6qhrFlYLqW/gyrj/LuX3ghqSfD9OHx7qrL5Y/uNZJrXISBz+Q2nNCXDYFKWKJ8J77bGfU4QIUIMnLl3eXHBfISaBJ1TyaCEzwNWo8phEGJTSquRy5xonhyL7UDH0u3ug0qTVux4b6erjN9WXJaWvJ9a/hns8egibsWD4OSS69VNSXCyxo6DPu0nJuHzRB9djOLPPXn6jalgeTCwjnIQ+juWSxXWZBLlIKTn0gcfBXWHJO88x3uxll+R+CKqjYDRveFEY/NlQ+d5GOX3X58s9Uo9MzAGMfk/XZHojKPhHDw1Ws476q1ZJVBU4/4w+qV5D6XzvmpW0nfOCULxLn5qpVnCYObP46OgPSC5HLGp4bSAGcVhfcxisuufZfJ6pj2eNrnSuBqxijfmB48h4U6PHRT6OLqDEqnxtn1jk0VcJA4pMsS9v1sYbYu6SkgIBOXhFsecJAwmF2LjDJnJrqmGCwB6Ib46p9I5iVNZxTR70zdaWzylmWbXZJADqFqr2MWspxFM/YOXo2jrcMEDf7n0a9MrdeIzPWcAoJkt3Q
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c939b6-3c02-434a-9dbf-08dbd9603c4b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:52:36.0544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTYTEWczGLy6doZjqk0xDhqZunApOA7OQfeOKGTycfbELnpWKtj9ELcFyIH4xRwSqusx/e12Qisf4scnmybjow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6467
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300122
X-Proofpoint-GUID: vOCavvrAke-h5y8n0zXMqB25AllHiQO6
X-Proofpoint-ORIG-GUID: vOCavvrAke-h5y8n0zXMqB25AllHiQO6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 30, 2023 at 09:15:17AM -0400, Jeff Layton wrote:
> On Mon, 2023-10-30 at 12:08 +1100, NeilBrown wrote:
> > If write_ports_addfd or write_ports_addxprt fail, they call nfsD_put()
> > without calling nfsd_last_thread().  This leaves nn->nfsd_serv pointing
> > to a structure that has been freed.
> > 
> > So export nfsd_last_thread() and call it when the nfsd_serv is about to
> > be destroy.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfsctl.c | 9 +++++++--
> >  fs/nfsd/nfsd.h   | 1 +
> >  fs/nfsd/nfssvc.c | 2 +-
> >  3 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 739ed5bf71cd..79efb1075f38 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -705,8 +705,10 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
> >  
> >  	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
> >  
> > -	if (err >= 0 &&
> > -	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > +	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> > +		nfsd_last_thread(net);
> > +	else if (err >= 0 &&
> > +		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> >  		svc_get(nn->nfsd_serv);
> >  
> >  	nfsd_put(net);
> > @@ -757,6 +759,9 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
> >  		svc_xprt_put(xprt);
> >  	}
> >  out_err:
> > +	if (!nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> > +		nfsd_last_thread(net);
> > +
> >  	nfsd_put(net);
> >  	return err;
> >  }
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index f5ff42f41ee7..3286ffacbc56 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -155,6 +155,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
> >  int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change);
> >  void nfsd_reset_versions(struct nfsd_net *nn);
> >  int nfsd_create_serv(struct net *net);
> > +void nfsd_last_thread(struct net *net);
> >  
> >  extern int nfsd_max_blksize;
> >  
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index d6122bb2d167..6c968c02cc29 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -542,7 +542,7 @@ static struct notifier_block nfsd_inet6addr_notifier = {
> >  /* Only used under nfsd_mutex, so this atomic may be overkill: */
> >  static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
> >  
> > -static void nfsd_last_thread(struct net *net)
> > +void nfsd_last_thread(struct net *net)
> >  {
> >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> >  	struct svc_serv *serv = nn->nfsd_serv;
> 
> This patch should fix the problem that I was seeing with write_ports,

Then let's add

Fixes: ec52361df99b ("SUNRPC: stop using ->sv_nrthreads as a refcount")

to this one, since it addresses a crasher seen in the wild.


> but it won't fix the hinky error cleanup in nfsd_svc. It looks like that
> does get fixed in patch #4 though, so I'm not too concerned.

Does that fix also need to be backported?


-- 
Chuck Lever

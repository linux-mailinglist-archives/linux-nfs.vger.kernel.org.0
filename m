Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C3C7744F9
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjHHSeM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 14:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjHHSds (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 14:33:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD71BA90B
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 10:56:28 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DATsJ029257;
        Tue, 8 Aug 2023 17:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=oGACsbsibvbhbN/ss5PqChvLdQgUBriLonW74+S28jU=;
 b=LWRA5NtyU9q92iP9VT/M9BydRkNRTDzwGS3Up2iM0mQwsLhAnbU2CFpm8qjS5pOKyVQl
 OypPGV+sMdEpN8HpUF2MMJCQazjYnGbpKyzUKjdA7cAwO+RKUg3prJRN8+nU+r07F69q
 anmdYIF6B6BglBNa5h+n2ExeFfIjfNNjk7Oe6/kZjLnc+A0JK0ogD6AXt+UZC6ybSXRG
 /MykZbkyRs8Tg6sgsSZExa8eB5PkRkndXSlSUhf4X2K/6Rf3t/lsmlBiOHGgW++8JRca
 265h4PlGwTNzHFC7g3ITHAPyNfYiVUcam4IW44OuO6o5xnMMndk0uOHeH29XED1IAqsH 4A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9dbc5ube-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 17:56:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378HBdRv030509;
        Tue, 8 Aug 2023 17:56:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvcc6tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 17:56:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMXhT44QYXmM9ToK2iWlMjYqikX+WACzmhqQzwjOj7dy/d9901M+MH0+qaLHx6RlHgt74rmUsCdunpt9P5JMBYMZFfMDGHWjeZN96OXHGrsSt0f8+SswPTOn/Ap5olsjajsfDjJDovnrdAx8AdQTLx4o3xtMdDBzcMmWuxmE9BA3y0ODVYZ4O9wu1LBZchUlocVvUrpmNYNOnjqq56HnhoqZDnGB2qtfwdhuo2ER+5avuMbsrtteGsBFo80vIanrMq4ZGe80R0UeTr/KHFAczhwvKTgffJmoDJtjYtjGhSzbfKbq2KqTcJDvsxgYx+6Phr4SUlFtvPCljmClUmUK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGACsbsibvbhbN/ss5PqChvLdQgUBriLonW74+S28jU=;
 b=kZ/TZJ8UWTJQbYuI4NAntQ+B8aeczTXXhooRApvAmxbNF3xgN88rwsD5pDEh8ULOohuFmgqxDLYz5ifJMu92V31hLe73qU7nNnVsdjID0iJ3cfgWUUTsGmBRSl+bxIP4uD0INxLjy32yDOrm5ChwTTycWwkJElU3SCtKi7RTwbrgoa4zFTlhGhExz1at/UV7pv/B7ZI5EG69+ZZ4a11IeUj2BwhkU9+BZ5wPBSb6gtYBteGvcEksKrB8rMdN0iAjEMrsDjTHnMZEtdNAalSGhVy/wRbXAGQGG93HtXcMBaE4Mqffaqltw3V5uItxOYYAVX2zxAFgfusXxjJJCPzg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGACsbsibvbhbN/ss5PqChvLdQgUBriLonW74+S28jU=;
 b=o3kvFCLMT9H+EGxF4mtddxdyzqBtRoOZhKBZWhVFDHN5BajNAS0WPDtXlAl2wsth8KMGVISfIvKXbs/sdhLIqj0Zyk4LvFAJnlqucdFo9hlPGushZzQxEzn1eHwbb1KQdJ5HokJm160R6s38RZivifI8FekhHdRqSXlvvFwLmaw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5843.namprd10.prod.outlook.com (2603:10b6:806:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 17:56:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 17:56:17 +0000
Date:   Tue, 8 Aug 2023 13:56:14 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
Message-ID: <ZNKBvgAMnOsDiaKQ@tissot.1015granger.net>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
 <169149440399.32308.1010201101079709026@noble.neil.brown.name>
 <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
 <ea598236b2da9f1aa9b587ca797afaa9de5545c7.camel@kernel.org>
 <ZNJLQIxweTaEsu16@tissot.1015granger.net>
 <ed02b06f96eeeca4d499583f2bdf31a433921aa1.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed02b06f96eeeca4d499583f2bdf31a433921aa1.camel@kernel.org>
X-ClientProxiedBy: CH0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:610:b1::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cfdd6aa-a562-4ace-3427-08db9838c383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0G2Qp/wZBdkhkc1hQeXbfizOkfIRF05GERYEDIAiK2cCziX6zelVrm/tQ2+tycYqqiP1i79GwqtlKo1FuskIrOIfXJo8qtfpFkLAJEVonw4hdvpNd9xwVzsnfP8S7Uhgsv3lfE/7HbBx8drsen1pz7Nvj5VyfTT5Eei2lY6moBt1pGzrL5ujAVTjEeaTax2vjXmx3dAzgL8gtgQP5cBJNOWjkSTPGqJTEwKbEPmY3bMfF5b/KmltUGA7DYd5KSUAHdHZhAfg+VKxpTa0t1bPWEDCPNAb+aG/zG3AARkuz1mYQqoFbgDt5gWW7UNnCqKCIjwET10lbHsXOzNd6Ra51pAKZrNDBAMjzc9JC7xx0eAlVUPGmGTvHy57UYFzjFKh+EJcj3V1386wfygOxIMlgV6V6SNkNdAMQ0P2Met19pXmde7+L1AMO8GgcW3lxVqzAhw4Y44shWD/k/8Ff08gjQOyPa1cImZxJ0n6i89TAFQ16uKE2gqp62XLAGYTpr9iHyhP+M0rPrMh43JErudLHXLXu9MxVwoZzHik15xhgfMCz/0GaCw2j5vVjCBvYC/M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(366004)(136003)(186006)(451199021)(1800799003)(2906002)(9686003)(6486002)(86362001)(6512007)(478600001)(26005)(6506007)(44832011)(316002)(8936002)(4326008)(41300700001)(66556008)(8676002)(66946007)(38100700002)(54906003)(5660300002)(6666004)(66476007)(6916009)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?82V0vemID2lQkSDf/rQzjweV8mY4uXBRRsKnToEmZ1Jv4zYswQDIdyGIkiJY?=
 =?us-ascii?Q?i6m5sKwKfdiS8gkhuf93aVyu1/xsJmXU9FxHo3PKFMfQjb57tK+H/MJll/TQ?=
 =?us-ascii?Q?HoM54cp/waarHyfvpYPTdg0eEHdkyuce+wJ/uwqLOa8N8Ve1V26o/9WcZdw3?=
 =?us-ascii?Q?pjv3eEnWqW0T6cFP986J8Lz/GnHdWd6xmUkqgbKLLyNR4wsk0I4PzW4jzlJW?=
 =?us-ascii?Q?BIdR7m2Kxs6XWzf3l8x6rmpc3HHh47RwdfoNDg5lWuip6Kneb4rumfDusCcs?=
 =?us-ascii?Q?JfbbbGNH7BF9lcYM96hKoc9QEecuLepvuLs599PU38ttKpSdPIi14t+b3AZJ?=
 =?us-ascii?Q?YHzHwrAv+NLj8muPiA0GMAlSrOJiBUjnhXdLSyOElc0InedNvxJKw5+KZ5P4?=
 =?us-ascii?Q?TphduJNBSqoE3FS2XLskuco+BAKM+puyi7GuTMDUWEmPD5Al10zJyMG9cpXx?=
 =?us-ascii?Q?rfFT8Y1NwzUOvOLTFV7ZVfxdPIhCW0p93sxS96sbxKBuzGRETjDgtXkhSvL3?=
 =?us-ascii?Q?Iwlm3K9EWRzjA4z/V/+s87Z5VfkOsyBJB1ZneN/Tlh7tVuqQI/aU8u2KbaLG?=
 =?us-ascii?Q?OfxNmWGJVjEuHsrwRKGjIQnAzHTEb0OB4VhhuUTWNwFrd5NQNJ6eQ37k9Z5Y?=
 =?us-ascii?Q?b63stAmIryyP+6fZrqpnKHQ4AScEtGIgGf418M6SLwHixwMyp9PSXe+yZFtX?=
 =?us-ascii?Q?jszUp+kolevpF4n5KPHeNmpoCbBZMWoFWByP5y1v5tBtl+RbEMCmDJqRXg1M?=
 =?us-ascii?Q?l8QuzimEaOV94mgVPstg3ZORoK4+p156LEYHjhLVVgHrD6UuCgAPr/EtLBhS?=
 =?us-ascii?Q?rSQnk+ahmmqsgszmo44DXqLu2gTN/Da4/MV3Rt3/bUYLWSXTk39PlbU4mcCx?=
 =?us-ascii?Q?f23rtUNrmNEyHn/etkFpWjwiUtP7gLx2i+RPpsIkEsb9vy8UbBb6t15EMi1C?=
 =?us-ascii?Q?oGKpNU60pKgWxZHbEUJlB+maQChQJ5IN9dkgV3vqq468/gRQc1nV5rwtGy82?=
 =?us-ascii?Q?RsDlib73JQPkjAVTu3PofD07RWAFxNgOAl/qo9H6b3LBdZ0swhZu7V4IVvg1?=
 =?us-ascii?Q?iJTscnXJoswCgQqeOUblDBjxyiknixuoF0Im5v8+VLweUoX7OAa3KM/hnf2I?=
 =?us-ascii?Q?HRFZMcFPAaKcSTHnn7UHm3znQFeaDMyYUu0WQmgGbMWNhOFpu3QS3RlubSTN?=
 =?us-ascii?Q?peLwxqaHVcKTr5l7ErzoKb+NwfzIU39EJKRZEoCzOsTqKYTWh06tNP9DcjJT?=
 =?us-ascii?Q?xLA+CRwjVqY/iL1MptLM8zEqeochZf5kbgQkqGTZCuQYCpFhlh0bYzzuPmHw?=
 =?us-ascii?Q?/LKfJWgRoiqM6ImMssXck/BHEp+d4aoeCnf91WAKdWNtGNjqVH4seE21uYA3?=
 =?us-ascii?Q?raahgzybEMDU1m2tVmMosfYyTIW2+Mu0GRMtshm6BoDYtgFkRas01LTrjgPi?=
 =?us-ascii?Q?cI3h6rUoz8oUYnnyWoAUxIHyOMyRZkq8lsBZe34mUFog9/Sks5R4xdH+KZqI?=
 =?us-ascii?Q?+BZkHZX9a98UQhKibpkUmWaIxT4wBg2IrReYotni9KtkTp532OGu32H/QrCK?=
 =?us-ascii?Q?PiqkVV1GihMG3qCQNB4irtYOCmZJqvnlaZz5ztJUTDKByy4qrCpsb6Yb+fQZ?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /ogmASlLGHmp999vTue0if2qlJBz1EJrcNFo4EoVhlYuZBUyuuoZjMt1XcDLLwJUNLHr7dePTsi2sgL2sIH78vzwfU6iu9N+9lUJ7SvZvWMcSAZlnHD+nhGTFxTR4XAx/jGmOONKrs/xkjhDoH8mBD5ZrKfCyL7aWR5SaAE/5LWg2HWMA+DPXwkTUxLM293+EL7Uj4J1h2Nrm7zzBPPXzQMeKIKtEvJ3mM3rpl/HGAxEKMwPFndnL8r04z+lta+FtNAzoSGsUYSvctAvH0wGRojGzxuydJi+NdjAwmUlX8Zv91K3Viu9ILO667pmelv4rpBM12Y8yYe9TvijAT1SojkGmknr7oTei3jzlT4KRVPqvCcLyewnZBOzmH3GYZ2LjBXENw9K2tjw/2oSLPmG9BOrtvuObgcVPta1JfufQXP02yrWwngFgPqs4C78NKfH4fGvkoUrV+IH/PSvTSBYgyNI3T5jT8uwhX2KkSJjXpLEbQ7OI7zDdNPPao/LpChfzCgCSkoxLxZDM/vmcOlXChctMoCQticXM2tqmoPR/9t9TAHsxnuZTu1twkn0qkp8qQ+wDS8Okp2IcFEe02fo2Vu61i/4L1J9b1DV3cRE7HcVlZhiMO4ORphu84VUaIPoRyW+oNdMcvqyNDb1PG96xTWYclMUf7Iron32vaqNSTxPZvNu7GJTVJZUfb/mqon8hM0bzd4ekV7C1mLftgvCLWVlL/gRy2ltglYkVbRU7txpJEivFUeWUNcDg5ILGvNSLslrKgtBbKSQKzOG6G/6LFyBiqG+zir3RSfjsfCSJyQ5qhwdPFYBpLC53GYDZpnMBA/TqNI8nZIjhVAlTf5/NQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfdd6aa-a562-4ace-3427-08db9838c383
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:56:17.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3g+K2xT3AAZ2HF5LpMjn0Mpl7aKdcYXcenpnF0tdw2LVApOuxIfPybyEFdmi+x1LHSb/fI+1ASqK0qNUZln2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5843
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_15,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=480
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080159
X-Proofpoint-ORIG-GUID: D-b34kHNI0CAv-S5ium7ACg01YVlm_MT
X-Proofpoint-GUID: D-b34kHNI0CAv-S5ium7ACg01YVlm_MT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 08, 2023 at 10:20:44AM -0400, Jeff Layton wrote:
> On Tue, 2023-08-08 at 10:03 -0400, Chuck Lever wrote:
> > On Tue, Aug 08, 2023 at 09:48:42AM -0400, Jeff Layton wrote:
> > > On Tue, 2023-08-08 at 09:24 -0400, Chuck Lever wrote:
> > > > On Tue, Aug 08, 2023 at 09:33:23PM +1000, NeilBrown wrote:
> > > > > On Tue, 08 Aug 2023, Lorenzo Bianconi wrote:
> > > > > > Introduce version field to nfsd_rpc_status handler in order to help
> > > > > > the user to maintain backward compatibility.
> > > > > 
> > > > > I wonder if this really helps.  What do I do if I see a version that I
> > > > > don't understand?  Ignore the whole file?  That doesn't make for a good
> > > > > user experience.
> > > > 
> > > > There is no UX consideration here. A user browsing the file directly
> > > > will not care about the version.
> > > > 
> > > > This file is intended to be parsable by scripts and they have to
> > > > keep up with the occasional changes in format. Scripts can handle an
> > > > unrecogized version however they like.
> > > > 
> > > > This is what we typically get with a made-up format that isn't .ini
> > > > or JSON or XML. The file format isn't self-documenting. The final
> > > > field on each row is a variable number of tokens, so it will be
> > > > nearly impossible to simply add another field without breaking
> > > > something.
> > > > 
> > > 
> > > It shouldn't be a variable number of tokens per line.
> > 
> > That's how NFSv4 COMPOUND operations are displayed. For example:
> > 
> > 0x5d58666f 0x000000d1 0x000186a3 NFSv4 COMPOUND 0000062034739371 192.168.103.67 0 192.168.103.56 20049 OP_SEQUENCE OP_PUTFH OP_READ
> > 
> > The list of operations in the displayed compound are currently
> > blank-separated tokens at the end of each row.
> > 
> 
> Oh! That's a bug in missed in my latest review then. The operations
> field was delimited by ':' chars at one point. Lorenzo, did you mean to
> change that?
> 
> IMO, the list of operations should be one field, separated by a distinct
> delimiter (like ':').
> 
> > 
> > > If there is, then that's a bug, IMO. We do want it to be simple to
> > > just add a new field, published version info notwithstanding.
> > 
> > They could be wrapped in curly braces, or separated by commas, to
> > make them all one token.
> > 
> > I haven't looked at NFSv3 output yet, but I expect those extra
> > tokens won't even be there in that case.
> > 
> 
> That's probably another bug. Anything not a v4 COMPOUND should have
> something as a placeholder. It could just be a single '-' character.

Confirmed, rows reporting NFSv3 procedures have nothing on the end.

I'll also note that rq_prog and the "NFSv" string are problematic.
Is it the case that all RPCs handled in this thread pool are going
to be NFS requests?

If we expect non-NFS requests to be handled in this thread pool
(like svc_wake_up or NFSACL) then the loop should simply skip
threads whose rq_prog != NFS_PROGRAM.

And, if the rpc_status file is supposed to display only NFS
requests (and I believe the answer to that is yes), then let's drop
the rq_prog field, since it will always show the same value.


> > JSON, yaml, or xml would all address the extensibility problem, just
> > as an alternative thought.
> > 
> 
> It would probably be fairly simple to output well-formed yaml instead.
> JSON and XML are a bit more of a pain.
> 
> For now, we can change the output. We do need to have this settled
> before this goes to Linus' tree though.

Lorenzo, I'll drop the v5 of this series from nfsd-next. When you're
ready, please send another version with the discussed changes
squashed in.


-- 
Chuck Lever

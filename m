Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C1774968
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 21:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHHTyu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 15:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjHHTyg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 15:54:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A912C2B
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 11:05:44 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DAkgm007305;
        Tue, 8 Aug 2023 14:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=B/TiRYKZ6KspAKqr8ghmo8dtTdXrRU3k1MrCbOnlErM=;
 b=K9a99zX4FJ+UkKBRmTByw5T5O3oZkXFhoUOB6a387MIecWDsPYG3KeWf1Vq81Shjf2pI
 RupZCtPT2jZ/Qagk7RxgB7fCms+A3NdLqpjVH45d4+2J6hoBcBCXhIvdZc3ElpRLXhxA
 ar/awhwrC2HKj26sYWeCytwLNyhStPqRP4hvkqbqUi88AGVkmMSQAdg1q+T8aqt3YDZs
 ON54z/r6qWFWpkGtrSfZL8+AOJAPRRbjfU1F4tOaKj/ihEefMMIUqWOl+CzR63X7QTTH
 iH+7mtQlHoMrsgyHN4Tqi3KAT86We+LQKwKDft4MHXnPrF4Mi0HWi4qFXR2EBZp2CRiy cg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9e1u5756-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 14:04:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378DxKal022942;
        Tue, 8 Aug 2023 14:03:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv633ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 14:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed9Zfg8XXKspXPCWuOdAy9/WtMU+NTpMy3zXNA9KUtOD44KNjzI0VzP5FSxpjLDRxVzauaX/0Kwxx7boSQhXRJ9FT0xVduUe/DHRd8HaGPkQ30TkdzWP/foKF45XXGwUKeqrdgiw8K6LlviqZQr8Eiz37naaReABYQ7YthHVrBeXZToxF7sTqnH0Jt/Gm1cL6W1+CDse5APm9sKGPTF2tkAS7m6IeGRZy07//lS49dulhViNKrtGkgBaJ6WbiUqMuHv7FXPTUADwl7GUU8fQRJpLZmwtjlMVJioRKzlZv9nFZULVlz+dy73fcVkr0JpwyhWH0OWYfu3HrSamwMRgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/TiRYKZ6KspAKqr8ghmo8dtTdXrRU3k1MrCbOnlErM=;
 b=YxEBtxALrcNJhSWvpJEuV7Nbr0YYU/WhenQ6Qmxb02IzceMjZVtyrnUraQTJy/4lTkMcCx5gs4E524PtyVxkOKRxZ1yP3+2hRPP18x3P43K+B2/eFESgUFraQg6hEXdXMZ1PPZUTbxVoqPBr6YTQVBJz7JlCSdcOD1MZnHp72hIxZj0Y4QDCXfMeKNNHVEVyfg4hk/FQXjy1Wfc5p76MCvHQNzP0CpSQeIFytA4BxGdplRtMcdU/9niSVWed2pCYnKguEWJp9YVSv2wEIBGZ+CsEcbr10ftMbWSihlzvmWXHDHZSJS4OwFF2La2048RZEChIG3PSW89o9wlcFl0A8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/TiRYKZ6KspAKqr8ghmo8dtTdXrRU3k1MrCbOnlErM=;
 b=IaUNbXm0Yp00S34eYf/lYmHoav6oBrCnavDBaNAeFLaFzW0PY29M1gyoHPbZacQB9ZhT3DwKFWJdLa2iubMN/tV7XxPlenUaKRh/Xk8JFUrLXwkpgGvJtH8Q21tRFi/Qn/Fgk/xbUjlNr7foZyNeIGiG5yrTS/7AqXlaiUSIYDs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5354.namprd10.prod.outlook.com (2603:10b6:610:df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 14:03:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 14:03:52 +0000
Date:   Tue, 8 Aug 2023 10:03:44 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
Message-ID: <ZNJLQIxweTaEsu16@tissot.1015granger.net>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
 <169149440399.32308.1010201101079709026@noble.neil.brown.name>
 <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
 <ea598236b2da9f1aa9b587ca797afaa9de5545c7.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea598236b2da9f1aa9b587ca797afaa9de5545c7.camel@kernel.org>
X-ClientProxiedBy: CH0PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:610:75::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5354:EE_
X-MS-Office365-Filtering-Correlation-Id: f788a19f-d121-4853-c53e-08db98184c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjIu0zQNtAEcDWvz2Y56U1Du5b8kc1n2Gp1RW56582YW2ADwyzmJKoAb7e3dt7GaWEBuvAeJoHi12wWwjJjxnJ/wqzlORssVrQnrcPdoCn/yp0M55VO2A4JbnCATVP4acg4LhIg0PKbe3/OIexUMULXHMIu1ZbwFntX9ZDJ1Mm9dDg6xF6pek0TEDzgbFQzWTAyEG49QPhw5njUFVV85WnPJXqhGu7pLEDx2+lc2Y9dyDm7hBaBBVFpRbL4c+anrHKziR/hP5vEDTKQKyV9jvWXZGsvb799TBI9bHYtHAt71DZFz5mYMMOLbbfJTA+bCImSpgo0xV/NT2u2+l3ncjlNqkjB67/rDEvb3EK/S9buUqpyOWlvozymS06YxlbZLV4eRCrP3iliTsXtq9RViCBFMsQzk1P+6KgF6GFTPYLe/SzsDi4AA9JfI0FzNO7zNF87O7H8/XdBJAXMsCHh4S8rwJGgyUfBbnz6hEFcIasaSwcYbUsd1lsUQXVatrUa04O7BGDL1jQ7bzq/aCTNENgrSZidXQZ+mC13miTQh5S/G1gqGbA3RI3ea6cbx5QCI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(186006)(1800799003)(6512007)(9686003)(4326008)(316002)(6916009)(38100700002)(54906003)(6506007)(6666004)(86362001)(66946007)(6486002)(66556008)(66476007)(478600001)(26005)(8936002)(41300700001)(8676002)(2906002)(83380400001)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPOY0gfk45H4Kw3tf5zni/Y05McL4QUPfnt6cq4CXN/wm2lQRA/k57q9FrDx?=
 =?us-ascii?Q?gzI5L8DsKpoW/x3rqwUA2gmTrmJaEqXbytLxoiNaeLgmDZQMdoGZUmH9/SbQ?=
 =?us-ascii?Q?Mo4+m0h4IZYCRwVD7hy1HzEtBYuyAu38bSEV3WSqt8DRz8JzCcZBB4uT6f53?=
 =?us-ascii?Q?FKZ/2F4WJx7vdJmxbGZ37BL5M+Sr9oMqNzru1t1E/MnULjzowf2NtssAIKDr?=
 =?us-ascii?Q?3W6tIV8ihkryY3HNTkocgP0Q5HEgmUtnKks+OlCU3L0ugiplZSwgPhjd5UQZ?=
 =?us-ascii?Q?64JxiVepuAqYjXgtlqS+1yfGv4gG8N1femnKP0x+ENP3tGrUuxLG38mtW8VE?=
 =?us-ascii?Q?PiZiaJ9VHjlGNimdZeagsEvQkBL/oExhBZhcCYpeqVH5frajlU1EzLl/efhf?=
 =?us-ascii?Q?qzwa+LarYmwpB64nmP9YOLKq1R94dGmCrQZKz2tMyaI2CW+4EmjjCkOlOmhw?=
 =?us-ascii?Q?XWOSUK0OBCj2S5QrfOdoPxG7dqPyIlL5Eq0vgrtb5/9x6ur3JQjusensbMUP?=
 =?us-ascii?Q?tRwTeFcpB1niVOmmjNFfUMy0R0Km4UqT2T3bZLbnItNYd9k/aKHkIei0KSHi?=
 =?us-ascii?Q?qG/TYR7SMiTvVZDSuoejNyOO8jBDJjX0Zj4ajsjW5lpTBMgam6RVuRReuDGo?=
 =?us-ascii?Q?WAqmWzxJWBe1KyAL/hDWoSEjFyAlT5UN67cGRwskgEvCKv5gJq++6KbZwtAu?=
 =?us-ascii?Q?7rMFbBuQ7wIOYVuX7X5Fc4jW2x6wzrAFAz2/x7SdUlNw0yJiDPY85KXDAhEx?=
 =?us-ascii?Q?qePJayz9g5QBzhSJMOjPnZ9a0cYz8IiRCiK/qm4+BL/Ly1uCVrem95HXSQKc?=
 =?us-ascii?Q?xsDex5cgJwk6qmtOxXnE7D/lP6RUz5shpmdFUJ9FUcsEq9nJMMQbWiNZYMlj?=
 =?us-ascii?Q?8iwMsxQgBGyyvcUV9spEb/+08uXqSpo1WOCLWg2JO5XkncmDHAcjRi8CIH4A?=
 =?us-ascii?Q?0EIPJA8kgtnHq4Z8K8qz/TSzWLWPWrsvAVUG3hFaQbMGmI2fC6FIrarTuTjR?=
 =?us-ascii?Q?aykXG1sq3GFYBvRKZfA9C+5E9c7wcDuvFDLvqLBLBlCpehkKLhw6lkF9DopO?=
 =?us-ascii?Q?deAP6JpLUQVDJg4/wRcG9MZszhXkDWLT32KRNmsA6eqVw8D1Pz4ueU3OtE2t?=
 =?us-ascii?Q?ByUeo0GiYawO6cFZ7ws0fKsn0aIVogPX+Lo1RU16Ht/ZUIx3/7VkCSRvMJ7F?=
 =?us-ascii?Q?4dbMr6olP7EITPIMcHw1NYbeJ9f3naMZVkD/VP12pLeN6jS8v2jWp0VDDBA+?=
 =?us-ascii?Q?QuBjlO9EzDO471NXWlN6u5xttznh+Za4Qw9PNKEutWGCiui7+i796oS6VSoI?=
 =?us-ascii?Q?fQsu/kbKZp5M9h1DglVef5imeKHjP4xNHBjKEuQEbth/9j0UbbrexhEys0ow?=
 =?us-ascii?Q?EJkV3iD8Gkcq4DJ1digZBH1XsolDsmuSwVDVtBAPgA7GoXH7zqGPtFXU9pUA?=
 =?us-ascii?Q?TjRHV3xOsx2aArlzJcpISZt6tyNV+1SvcW9MFBK6IRTSmuslW14zYuahCYMs?=
 =?us-ascii?Q?7LFMPEfLPJzgCJEgW5BYBBQ/y81pik5B4PWFSXhE34oiZaMuDOyZ6feWn+Yh?=
 =?us-ascii?Q?j9FySuHPMhbYJvIAAAuoUPNShpMFtYyDD4WBxT+RLl+gXyr6JLcXRLQozMhC?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: knny5sNESClPh00bqaz8L+upIe0GiS/yOYQW39YYnp1cgMV8Kiji/ZAXOhvTbfblD0CfbaoFPPIQo2XyQlUJR27EyopUzWBTG2gFDI1SnWWkKzwHss4DrKuozcuZ9tSJLfSLAtp7+TR4gKq0tXRICMApTioWAKvf5BodNPnpPtOIUVIhKm52e064w0tMO+TyBm8IAu+Wh1U7vHqw4yFDMlyxxSMcNd8/h3nGna7ffCDUfBLQ6nEGZoKKneeWfa9lQe4hirbdQ5OfdvyNGMYMFRwcTQvh4OqRjuhz8riMsSPSgS4qRdXgDZaLwGpn7CjfWtJu641GHApX/EVTszrxZjwydjBoRB326pIxe2lhKRzoBjC2F7SU9uevzBaT4e5iAgwMXa230o1wvMCrWDGTwRP4SlwY7TVi7Vbf8YTQYqh/nu4BvXCa+la/d77QYlW9qFee49y/ZgQmNnKW6kXAA5uXGwwYRgNciIMbN37go8C9mGOdnII+tMp142Oh0BZJTziYX80COs7PYrenvRXgw4LVrnJ+UyGCa8OaTFIxnmoOa9xr7Fb9aRSrom2O36xOY4gL2SKvDil2r/O+v1nwl9mirrJT0BpzJs4gjLj9cZSZSS1nt7Ul//Sdmaq8Fp2Qn62H6dEaNqVRHdtUTU6BIomTSmNdpfzDW8n0R3b6/sixJiowgo4kQNK01IpGUHx5AKsdNOtXbLMpdjYXDu1T533s2rr7513u3t1u8DfHfTH9U3xkeXesv7TJnNCchICjuU4AxpJkKsNj4AD2Yw0O6pOcTp/xe192+O0HjzN68V7J0ueXPfXy0dHIvxpGy17c0ZVPUqRIcgPZHhOs4NLpDQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f788a19f-d121-4853-c53e-08db98184c2d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:03:52.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGSZn1aTlJIZQBbMlGL1mefBhSW3hVYQaeH2iegaKTiN9PyVxcbbj5Wci9fDx/4dizd2tMO9QJCS59/B26FfNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_12,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=71 suspectscore=0 spamscore=71
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=-39
 mlxscore=71 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080126
X-Proofpoint-GUID: JboG-3c190pGg4BdbUHCDPEldjP83A4_
X-Proofpoint-ORIG-GUID: JboG-3c190pGg4BdbUHCDPEldjP83A4_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 08, 2023 at 09:48:42AM -0400, Jeff Layton wrote:
> On Tue, 2023-08-08 at 09:24 -0400, Chuck Lever wrote:
> > On Tue, Aug 08, 2023 at 09:33:23PM +1000, NeilBrown wrote:
> > > On Tue, 08 Aug 2023, Lorenzo Bianconi wrote:
> > > > Introduce version field to nfsd_rpc_status handler in order to help
> > > > the user to maintain backward compatibility.
> > > 
> > > I wonder if this really helps.  What do I do if I see a version that I
> > > don't understand?  Ignore the whole file?  That doesn't make for a good
> > > user experience.
> > 
> > There is no UX consideration here. A user browsing the file directly
> > will not care about the version.
> > 
> > This file is intended to be parsable by scripts and they have to
> > keep up with the occasional changes in format. Scripts can handle an
> > unrecogized version however they like.
> > 
> > This is what we typically get with a made-up format that isn't .ini
> > or JSON or XML. The file format isn't self-documenting. The final
> > field on each row is a variable number of tokens, so it will be
> > nearly impossible to simply add another field without breaking
> > something.
> > 
> 
> It shouldn't be a variable number of tokens per line.

That's how NFSv4 COMPOUND operations are displayed. For example:

0x5d58666f 0x000000d1 0x000186a3 NFSv4 COMPOUND 0000062034739371 192.168.103.67 0 192.168.103.56 20049 OP_SEQUENCE OP_PUTFH OP_READ

The list of operations in the displayed compound are currently
blank-separated tokens at the end of each row.


> If there is, then that's a bug, IMO. We do want it to be simple to
> just add a new field, published version info notwithstanding.

They could be wrapped in curly braces, or separated by commas, to
make them all one token.

I haven't looked at NFSv3 output yet, but I expect those extra
tokens won't even be there in that case.

JSON, yaml, or xml would all address the extensibility problem, just
as an alternative thought.


-- 
Chuck Lever

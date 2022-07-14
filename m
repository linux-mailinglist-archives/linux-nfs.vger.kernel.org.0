Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009A05753D4
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 19:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiGNRQ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiGNRQ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 13:16:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E682A474E6
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 10:16:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EG53qc006431;
        Thu, 14 Jul 2022 17:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sNNCtrNulbiaWpiWNi9s74gb5RCDN++exJAXvFwrKZ8=;
 b=wrFrHTy6twLMYWVs4nn5WkRJ97XmqKu0fV7woOHVw7CXSEGg013ZPdx871+a4Sj1deJ4
 VP/Medp6Bt6RrBflZ88nSyM58kL0bR4bvJQr+tsaf70nV/eBgnntcT5Jpf6s7k/ybcbC
 MWbf0VUfBULRC05TyJTdAPz4g8kBcjh3fJAaLkZqpTNjr4pVyTVji3tb4/v4H82c3hMu
 bdi8W0kCJA50yLPUo0y5x5O2ZHIPofxweik7D9ie0gX4Xv0P4r8B5t3J86hvUx5+TTk9
 25aspjOG+EKLrrcDftLCH4ADulc6rgjSDhXB5UiTew0OrOD9iwGO58JCnoFGIFFOu0Xv Ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rg5p22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 17:16:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EHBR0N021808;
        Thu, 14 Jul 2022 17:16:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7046gtgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 17:16:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/Itt2Hq9GCAVZp07NZo+TbzgsqO2griSJ4x96GhRKUBTqpYuUpoPI62Wm+4lWuwTvuT1PiZ0zavDteM/jF2zzjLbKRHfzgmvdTChrPdPCXCC3RBV8AaSuBUaZ8ZGhyEB/DWjeRrIqorlCuXIhybMBZz8dc0Vn2bZYQ3ep9WZm8dvyzAlagAQ7g3ASARo1Goa/BJw5Or4t6kF0hHcdVSufq7P37jcxPJz1jLJ/mfwY/809isI52apMN/1peN7z57uvXlyeocKbUDyP2399c2oFQ1Z5YNfyDwfS8L1yqcl92r9VlROxMGapOtNWWv4zkW1Mgsv2ISXOiXVlLUGeLYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNNCtrNulbiaWpiWNi9s74gb5RCDN++exJAXvFwrKZ8=;
 b=JLKfnQKaxP3gDAiyvLDFT4f3i5Av1rAcfXKJpcdL2sDhTtTDaHYU/Fo5dHU3UbYLdoIMK0eaTQhImGvKvzeqeOxsJfOnw8amuEBz17RwYijV7ZPxZTWQwuD+LbXj3dCJ3QXayyj8RDF1QirrixpV8X1PzxPuixe6nDF8BV1jdNI0LE35mkC3Rmm4Q/a9WQOhYaVJkaL6bdDUtQivUz5CO3dTDjdXjEpSPXDMkm7xPV08XrnN8BI8D0ZT9fHzyXq1wZhSjzfrCjlp9v1wuBF8zwofgFJA+k6sFcdiJoTx2YX39j7tsdFLoWe2Bwc9wE4B3fAlJefjbwpQ6IXPDJpqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNNCtrNulbiaWpiWNi9s74gb5RCDN++exJAXvFwrKZ8=;
 b=b63Q41V46OrNgeBAu1UbrBrvEML5FtrPE0SUROr65n6+FxQGNHnz0z35J1mTGuvQH297ceVJgbbn8Vg9xlacMEF9Hy5DYbmxBW1q3usjQCBLECMRdx7sgwnlIigzqK/YPWidI9BlPk0edWwegBYa5Ffk/wgq5t3YRPAOgHDp/pM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 17:16:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.015; Thu, 14 Jul 2022
 17:16:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] nfsd: vet the opened dentry after setting a
 delegation
Thread-Topic: [RFC PATCH 3/3] nfsd: vet the opened dentry after setting a
 delegation
Thread-Index: AQHYl5Zd8iYZiuQn7Uu02hG/3WLfuK1+FU4AgAAFBICAAAF7gA==
Date:   Thu, 14 Jul 2022 17:16:43 +0000
Message-ID: <87EC2FB8-EA8A-4322-8725-A6494B606317@oracle.com>
References: <20220714152819.128276-1-jlayton@kernel.org>
 <20220714152819.128276-4-jlayton@kernel.org>
 <F7B94422-F889-49DA-AA38-0D8AA1F9B682@oracle.com>
 <fc9e2f339e9a84912e9e4644292bec44b5e49137.camel@kernel.org>
In-Reply-To: <fc9e2f339e9a84912e9e4644292bec44b5e49137.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5931ea91-1e15-4cf7-c16c-08da65bca007
x-ms-traffictypediagnostic: CO1PR10MB4531:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsZufl/B7CyeG2UYQeuIe4knNTzXvEXAmp8XfzwsgPcJpabeK1KlWcGsWZVcbdtZ6PXRhMNh9JQSut+OV4dtVCxQkzoQ3VneGeO53jxRQusETQdAs3jT2aILNl+nfPkiLsGk4Cv1kEYD4B8Y9+oqQgYcuYEDSlz6ym6cVKa1rysKMVPHpEQyl25Zbp3z/FYiMrd58AKHk6lq//hRQA9TWsKF1+fSqy4tEAk52qQc134Kc92GpYQYXCj5pnz0ongLxBUX3dNKBi35sKOz+vFvRKeKvzM9F4We+rRMW+oWAcvlkDhi4nlc3xCGoCAy6OPC37a9ZHOMy0gu6zld/8uUERuPXOo7cs2x9F9og+pFthJ7TrJHZo0h2dnvXFcdBn4WDppAXSbh7rY0ge/0i7/bx9InQmpuvD6X5vSI8Tn+n9phaWizXqhJCOE0n1abU82LXdeqLKt8xRmGw24L+9YKGY2lQih6er3R96OkjpuHuS1i0HyNsrdbDsbPTeBceLS6JJpRrH3r35HYMZdlfxqmvuQgYf362tiXOxcxXVOmJb0UgnqBThK4LC0va2FHdk7F9VMEuHqUhbKcl29TD9U2Sc165Gf0I9I66o5gayu1XMDOv20Gw/Ax13Bd+if6ljDQXhob59gihjVkls3eeqWAOvcAJmV4ekc6xeCmIh87WVxLOJ6oL7gZuqBuDLq6k7fjWpm46OFhuKU+HdFKCjdRmEfeI3Dmg/QGuyClUL7cdBqHBzkSRjx2tvkrL9gv09jGFJsmirzRSeKaw7D1I6rSIKBMprgP8Iu01k+lLNJE24wuqtFdIcECWhAjOHTGkQLpQkmNOUSCDo9dRozCeqYB92rnilrusoq8o1S/N7b+co0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(136003)(39860400002)(366004)(71200400001)(54906003)(6916009)(316002)(186003)(86362001)(83380400001)(2616005)(41300700001)(478600001)(6486002)(26005)(6512007)(53546011)(6506007)(2906002)(8936002)(5660300002)(36756003)(38070700005)(122000001)(38100700002)(66476007)(66446008)(66946007)(64756008)(66556008)(8676002)(76116006)(91956017)(4326008)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nECTZ1CORQLsT4ylJt4198HbX3PXmDwHL+z9YrHDl0XLIDJZZ+S7IT3JhO6t?=
 =?us-ascii?Q?ext7gWjByQlc/9gfe7Slps/HGtwir6gvMzEToPwcyyofap0LDdfrUZnXV3vA?=
 =?us-ascii?Q?yxCDLBL7n2RyFZsPlAf9+Q4oj2JumRmX0GFaQR1Wo7xEyqrD3VTa1u1b/Y+u?=
 =?us-ascii?Q?zlIQqqu6SW/HEYow6EeiewHin5s1leVQw3g01vJ5ufJegz/0E4CisN3tMjdf?=
 =?us-ascii?Q?MLi25i62VsPCKKTkpdPYgEvA3Je1EmPJcy9xj1wPInYjplXnotKxDT3T23Rw?=
 =?us-ascii?Q?cnC4b+XZu/wUcwCMsF/oQIGx38fMvrcBIiloz0vzCO3gQYwB57kPZsxVY+tZ?=
 =?us-ascii?Q?6K0HbEvbHMBcQM8A7fY7juce8aDVZRMdPQ8quEQ814mihlcchvh441vzUoh5?=
 =?us-ascii?Q?dDizHxmZUlknHI8dVyRZFTWXh7GE+kNKrXT9YbnLd/bqrnRr8jMm8ffTsc4f?=
 =?us-ascii?Q?dQPXw8ofDHuEVdQjCNqQnu1b9eHxugft192T4PpBDNLY1+ygfejNfZ13h35x?=
 =?us-ascii?Q?zWIhjNYzL8/Gy6NQXEImg8U4Z9gY5d+MsAkOPAsiaj0x3xokwS1M4gkIyulL?=
 =?us-ascii?Q?pJI9lERXEdSE0z8jIr6S9xTSoSPScw7I2Dw8zaRtvtFRgdXJzKKmIgktCBXh?=
 =?us-ascii?Q?gj7UMA+S69X3BgRJNxYN2s2Kf5AS9bDZFp87ixUbyf62bQpTerYnXQGfPHw0?=
 =?us-ascii?Q?YZZRpWQn2N/mY4Ph7VFi3zCIoql3a0w4D5JpRjuB16/PyC6erH2yLzMODspF?=
 =?us-ascii?Q?2QfxZpbSH6UjQd2F4z8LCvNgERBgvOfpOhVr81aKTNeI8H1Cu+Y5g0pDziml?=
 =?us-ascii?Q?jPbaC9U9qO3wk6l+a5VeZoO9AxxD5dMtiCPbCrfA2eIxc2knCHJ003cPcLYK?=
 =?us-ascii?Q?R1IZkSZ6n6Ye4jGNchE4jHrN9IGOntmaXzbSYWKbTj4ar6jA5U+UmzmFZqSV?=
 =?us-ascii?Q?yrKMqfU2NDOvNZ0GMQi+TalvTqjVtDJIrzDOw4h3OEtJbcFafXve6yr2lpOg?=
 =?us-ascii?Q?KWV5ztWx3QyCMSfZNr6EUgwoOmAzqH1+eVVBLTTWzl4sfrwM7XLRKbvP+Wi7?=
 =?us-ascii?Q?vmmK/nIbu8l8bB5eYTwQyW95r1aQREnjX8Z2x2sxqxHafyphDAtG/LpmcYaB?=
 =?us-ascii?Q?7jYM/M1s706E0wcEE08KYI3IqCDtgxhovkfOQcKCILTyYqCS+yqyu58pyeu4?=
 =?us-ascii?Q?gzRLon+3RMTLFLbKh/R25VGsGfou0C1wf5/o/xNQsUbM242JPb8e9+q7/LHi?=
 =?us-ascii?Q?iSdL0UwnTbbjtKK/+tSJCdORx/sX4Bqqu7J14VOLyuxmTP7OufoiUdOOgJNn?=
 =?us-ascii?Q?NTy8ARPgMzjwOyQbDvCRRNY0rtoBU2xJx00I1tDoXrlb/NZY0pqu8UMr8yhR?=
 =?us-ascii?Q?ea9YHilA1IwXWTudClHYKm0d5huh95Ejtf8MR6T2FRrGXfeY+O1wrvq8WBRT?=
 =?us-ascii?Q?lSKwO2zROAX9zse+/tvU5HQLeKBh38XQVTTunS1JB2idhzDDilX51zH6xS7w?=
 =?us-ascii?Q?Gaxbbi6DlyTbwloE0fFmXLYuaNuT1DUb5FBrAk2QKbsBxAa+Ik+eqFudjz+z?=
 =?us-ascii?Q?BnHCS06dEVYvMnjQON7L36ItkctjmtXFwkdQF8b++7zT8Cu/PrGBkufsFUn6?=
 =?us-ascii?Q?mA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3328E6C146D9A41B7C0ACC921170B59@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5931ea91-1e15-4cf7-c16c-08da65bca007
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 17:16:43.8997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVYLZHyCduJXiYJDAjzNcPMJDgV4v9Kyu+d1qK74YTMjLvA+gh3yJA7pFFTWfii9skIH3Qr+58mjYznmndjvNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_14:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=916 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140075
X-Proofpoint-GUID: ecuYAM_6BWenryqjHPjxjwV6KJX18Osn
X-Proofpoint-ORIG-GUID: ecuYAM_6BWenryqjHPjxjwV6KJX18Osn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 14, 2022, at 1:11 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Thu, 2022-07-14 at 16:53 +0000, Chuck Lever III wrote:
>>=20
>>> On Jul 14, 2022, at 11:28 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> Between opening a file and setting a delegation on it, someone could
>>> rename or unlink the dentry. If this happens, we do not want to grant a
>>> delegation on the open.
>>>=20
>>> Take the i_rwsem before setting the delegation. If we're granted a
>>> lease, redo the lookup of the file being opened and validate that the
>>> resulting dentry matches the one in the open file description. We only
>>> need to do this for the CLAIM_NULL open case however.
>>>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> fs/nfsd/nfs4state.c | 55 ++++++++++++++++++++++++++++++++++++++++-----
>>> 1 file changed, 50 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 347794028c98..e5c7f6690d2d 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -1172,6 +1172,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct =
nfs4_file *fp,
>>>=20
>>> void
>>> nfs4_put_stid(struct nfs4_stid *s)
>>> +	__releases(&clp->cl_lock)
>>> {
>>> 	struct nfs4_file *fp =3D s->sc_file;
>>> 	struct nfs4_client *clp =3D s->sc_client;
>>=20
>> This hunk causes a bunch of new sparse warnings:
>>=20
>> /home/cel/src/linux/klimt/include/linux/list.h:137:19: warning: context =
imbalance in 'put_clnt_odstate' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1174:1: warning: context i=
mbalance in 'nfs4_put_stid' - different lock contexts for basic block
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1230:13: warning: context =
imbalance in 'destroy_unhashed_deleg' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1528:17: warning: context =
imbalance in 'release_lock_stateid' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1624:17: warning: context =
imbalance in 'release_last_closed_stateid' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:2212:22: warning: context =
imbalance in '__destroy_client' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4481:17: warning: context =
imbalance in 'nfsd4_find_and_lock_existing_open' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4557:25: warning: context =
imbalance in 'init_open_stateid' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4606:17: warning: context =
imbalance in 'move_to_close_lru' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:4752:13: warning: context =
imbalance in 'nfsd4_cb_recall_release' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5003:17: warning: context =
imbalance in 'nfs4_check_deleg' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5392:9: warning: context i=
mbalance in 'nfs4_set_delegation' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5467:9: warning: context i=
mbalance in 'nfs4_open_delegation' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5619:17: warning: context =
imbalance in 'nfsd4_process_open2' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5638:17: warning: context =
imbalance in 'nfsd4_cleanup_open_state' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:5934:27: warning: context =
imbalance in 'nfs4_laundromat' - different lock contexts for basic block
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6160:17: warning: context =
imbalance in 'nfsd4_lookup_stateid' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6374:25: warning: context =
imbalance in 'nfs4_preprocess_stateid_op' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6422:9: warning: context i=
mbalance in 'nfsd4_free_lock_stateid' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6459:28: warning: context =
imbalance in 'nfsd4_free_stateid' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6528:17: warning: context =
imbalance in 'nfs4_preprocess_seqid_op' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6545:17: warning: context =
imbalance in 'nfs4_preprocess_confirmed_seqid_op' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6588:9: warning: context i=
mbalance in 'nfsd4_open_confirm' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6657:9: warning: context i=
mbalance in 'nfsd4_open_downgrade' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6730:9: warning: context i=
mbalance in 'nfsd4_close' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:6762:9: warning: context i=
mbalance in 'nfsd4_delegreturn' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7034:17: warning: context =
imbalance in 'init_lock_stateid' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7063:17: warning: context =
imbalance in 'find_or_create_lock_stateid' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7362:17: warning: context =
imbalance in 'nfsd4_lock' - unexpected unlock
>> /home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:7535:9: warning: context i=
mbalance in 'nfsd4_locku' - unexpected unlock
>>=20
>> Let's repair the "/home/cel/src/linux/klimt/fs/nfsd/nfs4state.c:1185:9:
>> warning: context imbalance in 'nfs4_put_stid' - unexpected unlock" messa=
ge
>> in a separate patch.
>>=20
>=20
>=20
> Yeah, I saw that too after I sent this. That hunk doesn't belong in
> here. I'll drop it from my local copy.

Well, I'm interested in trying to get rid of the existing sparse
warnings too, since those tend to block our ability to see new
warnings that arise.

If you have suggestions or proposals, please send them!


--
Chuck Lever




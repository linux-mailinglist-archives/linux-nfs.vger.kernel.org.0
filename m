Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4F357E60B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 19:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiGVRzc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 13:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiGVRzc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 13:55:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2935A183A3
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 10:55:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MH4PFD006529;
        Fri, 22 Jul 2022 17:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qD4mNRYjnlm0d8A1myKJ6RyI0r+zbUrUfjw7qSXKVr0=;
 b=SO6acSxaW7tuvcRpDk/kHtnR1TqbZWXQkCK9Y3AGkjtPh7qGO1o+pmmgUi0+sl9cbhj9
 Weyxe0k5nxP1HiNP6MIAWgVinOEwc9cqvZSlOBSsD9tz8KdQvnaFLiJGRSDGYXIEI9bY
 5zG8tIvUyzRkIk4beGksB4qUCcaBDW8mM82Fer36MQMw9vgjkle0IhO9vyj2nZtuIK/e
 hiBXdTx9QbZFneVSykEwm85gzkPr86AZ2jdO/WCh85+CyGiJ/E6blbSLKTV8DgSIC0cA
 oeFkAEsw4umElc5u+giwAsGkHgyE2MDroNewYildf+0ruCQSqMDUOvtokoMtNiMq+6gw pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx186qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 17:55:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MFOEZs009934;
        Fri, 22 Jul 2022 17:55:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gm05bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 17:55:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJXzx3oPFepMKcV+CWCQg4dRFvDUfdQIMMnSyxapprzd2cv4/hhAiNKUu6X/xusBoMFPFx+ErsLCpQpeqcXBqEukeo7bsO6JZP6G/4phYkB+u7J2HBBPPuxq5BE7ILfkX1f+aG5pBt06CSkQFIImqWlkaVv3c1fdyLryT8pVNqF7TNKyJj/d1tXYgutGD5Eq3XN9imDchZEkVU09IYuPZrB3FkW+NwSfGnBvBZi+kcORRssP2mfS95b8eiAnFtKpvBqENlfMnw5GL/clZXt4maeT/hbD5ejR+dY3NEEDDaDkfLajC78E2DoHmRTt5vGarrK6VqpCLpP1orreWUfQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD4mNRYjnlm0d8A1myKJ6RyI0r+zbUrUfjw7qSXKVr0=;
 b=ZZZwl0Ze1Uve8O2h1s7GIVEYA0lu9ErzhQVLAj1g8hHC9Ia10cRHCyywkXhLLsUDI8sRJfCW8E2o+N5S1Yx+Caazlywge1Y799+oq42+0F4uYJnosNjuwE4v810prPnHwQK54Qotmi+Joi8HI7B/OpP1sMKubNVgCuxOTwvlLxM4BWmaToOwpbDxsPeI9aS38sZXG0KLM+ewaxnEYOI1T1G4CvNknq0u3TgWyLd/zPgEVlrKJF7wRk0NYntcDIaqQKEiY/UinIpV23rFwEq86xM/SY+LpcI4Qemprc6iQhEvS7FBfQhs3Cm9r1fUphUr8Bybvemh5A9i5NvaTlIGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD4mNRYjnlm0d8A1myKJ6RyI0r+zbUrUfjw7qSXKVr0=;
 b=jJ3XCgEUYMh4tlmVDMtZnVNXhVQI3nATyGwqA/HuoyoIm+OSeVhU4qk+pbTzY/8scUjRD2cymFJXLBQYRBonxgwU2ziuiglAohW3PK4BJuzV19H/U7EaJxkBtj40wNYeeGY7zfsQhaOC7qlmqpATNOcbY2VdmvfURSkn39Sgw8w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1994.namprd10.prod.outlook.com (2603:10b6:3:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Fri, 22 Jul
 2022 17:55:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 17:55:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] SUNRPC: Widen rpc_task::tk_flags
Thread-Topic: [PATCH 2/4] SUNRPC: Widen rpc_task::tk_flags
Thread-Index: AQHYnfAYpiEwiP5Q3kuMeAXmLUJIKa2KrAOAgAAAjAA=
Date:   Fri, 22 Jul 2022 17:55:25 +0000
Message-ID: <F3BA47F3-DE56-45DA-8E4A-4E8A65D5541A@oracle.com>
References: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
 <165851073589.361126.4062184829827389945.stgit@morisot.1015granger.net>
 <55155a8f566599ecf802103a8d7d3aa4ea3e421a.camel@hammerspace.com>
In-Reply-To: <55155a8f566599ecf802103a8d7d3aa4ea3e421a.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b42baedc-83fc-42f4-68e4-08da6c0b5ad4
x-ms-traffictypediagnostic: DM5PR10MB1994:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CWa1wy6OnJJz8Aon84eQ/gMgRV0U5JO+9lAqn4FUfaONRzDMsr3XS5MHXRxn96drXD85Z7JtH6KzezMzOV+kU++RbAk+JVy/deyM4MfP88AvHCKbmvDXkmLd8b0c5AB88g4y36Ih39omLpHrctZ1RpgKJ+txJ2mI23tlnbPc7EdDp7ItVmRhQbELwXVJX2Y8gKptRxqNt3RbA4tlSKs6Fi+Pq1fIdFYLCJ4EMoz4cyKvv93hXwgsNGblJPMaABktcQRxsk1wICcGE2sB8UZwfsVHgV9EzE2RWsWySSMKRYCfo1yhnQ0hiHo2TijHEicv49zIZVUh2a50VQnLDYfu4cbmS+hZdDJyOa3mgXhMSyL5SrYIPbubRiUx3rUtwR268e1GC0fSJcDzXL/ukqdBe4I7vMvs9WJkkoBp/xmRIY0BH+gbJy6Q7gsjweO6xpz2sFCdO9LtDIMVyDpaNtv659aAXQI81fKPRlXwCBynv5Pscq9u0e5EZekENs93NglWIwueB98s3LyNrgdfidUxZr7G5Pgcj8nzpMkPCf+8tStXhpgVYiq8Qmd6S1ZrSC66m9c/jKyppJzAjt0Eu/YjlNpCcC9IGaKdMykiesTridwoHMBNWRAY44s0m7xOeCjpStbdSEubMzZ9zDhQh4KQU73xTlCkTaBZ/Yzr1kpGD8wjL/QbrNsTH/bxlSfiSfRfzY9bLxnx0in+h9+Mi5B/RYS7G0BzKyrLFqgnp3I/RxEyycn/lPp9TAIQNWleZDizuk4QEi8nlpJMzqX96tRy8HeLIUQNMGi96tEf47zd1HhYNHoC9l2PYFwJMDzj/ZIQPoh9ytdn7SQVte4a2JTPAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(376002)(39860400002)(346002)(5660300002)(2906002)(26005)(86362001)(53546011)(33656002)(38070700005)(38100700002)(66476007)(6512007)(6506007)(316002)(122000001)(66556008)(8936002)(41300700001)(91956017)(478600001)(71200400001)(83380400001)(6486002)(66946007)(8676002)(66446008)(2616005)(64756008)(54906003)(6916009)(36756003)(76116006)(4326008)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z/zr/oUJzp3dKzIcSde1J2gz6b5vs8k0aGlpsO/ArKHBg/av2mbqwJtbpk0m?=
 =?us-ascii?Q?f9LfbVHDTz7ssEcJKbL1oAtc22DUwBrJayLCM44hsTcUf6nsjikMfgXpuVbW?=
 =?us-ascii?Q?368Ia5vby5sOj6enAINifSbWle+DJylm9KEl/C7QbD6FfOCUitP75ILHvirU?=
 =?us-ascii?Q?/MqD0vzEmDnGfh1GnRQbv0fFfMHmkJ2xQGYJBjv4z49XTkwM6ZUfoAmfoB8Z?=
 =?us-ascii?Q?Jgmh9F6nktUGuij8u1cuMIRNxBExh32vaSwbAKt3AYhljmG3nap+AR3eb//X?=
 =?us-ascii?Q?xOOofnc1pYxEbC2pryUhJIgCnXnyqBBavvxlTNNnXJlI1MEyiC6GUBPG4aRF?=
 =?us-ascii?Q?4ECPCPMA2+crNv7tMdmaifeLluTKG5/4WF7HXOZuKnw3W7YoAL9SFkb8Py6Z?=
 =?us-ascii?Q?2g3jKip3F95r8q6htgugS5+k2RgETL/NK37wEsjGQ23shVbvday3E90d6tVi?=
 =?us-ascii?Q?M0K1k51gE9BrUOpDJIXCRawcKQT9R6t7AGYbEoNbDqSws3epLQHl+m8oQc9N?=
 =?us-ascii?Q?7yYb+AYpV9XhFHtuxjUshmE16cC2xglUbomOGRVZ+YwFRuS2YoNQnMIrEghz?=
 =?us-ascii?Q?MgWJ2ppGmyomZZe2SmAZHGfBfxVLuoHuSAIuMsuIsjRkzcJswLS2Pq23Czvc?=
 =?us-ascii?Q?gkAJghm+deAEXKhU6jS330pHSn8mY03YKLXvkNZjlIhzQwsujup97d/nd08G?=
 =?us-ascii?Q?FUlY2yjFgPLORVReulw3SgTstGvtYEa43i04uTG9UuB3wiTjMxuqGIpmkXd6?=
 =?us-ascii?Q?T5YFSWAO2GuRTIn83ITOhHBdtupjRY4MWdvF9l45kyPhBmZpn5nbFIjp6zii?=
 =?us-ascii?Q?SHFLKCD6WjWnqMwNQ4mo78ymXejMK2SYhnTR8BWaEeNWKOsuGHgHjJmwyZ6a?=
 =?us-ascii?Q?Xy3whGxFksnMnYpFR3MILqRNa2ZtKwu5++aCufzRGRbrS4bxsNP3Viq9Stmz?=
 =?us-ascii?Q?A6j0/f70eDhU6XYAb08fMkwtskbtVsq9E3p658U/H4YpymVsFmSxWzNQE9Tv?=
 =?us-ascii?Q?OWl4evsr2f68HBW6nQBlFaJ7a/ExN0QbBNH/Ahg86lZpD6akjxHofwzA+McW?=
 =?us-ascii?Q?gSAxvHl6niMnO1nUjXXD2ppiPtocCNBimp9EUV5a7p3oNl+aLcqbTcUKU23Z?=
 =?us-ascii?Q?0XvHjdpTVZDbrgTGg921Ep6k7lls7H7rvlL8enoZ9vXJZXZkYfqfa2XEZ4h9?=
 =?us-ascii?Q?xZAi8CAfmEuTg19fpA5064lZUVNsvNb1YCD7y3/axEFJl1/4TN/uAX8d3dnz?=
 =?us-ascii?Q?FNMU9zi1f7gxtbzlI6/YBnu6SH01TIdlmsTOoTEmAtVQPNoxdd6fvCVY9C9Y?=
 =?us-ascii?Q?kLgvOAR8YVuXfwGIzzY5Z17YO4dWI9Dcf/cc/qGS3BzlOehkFjfY+rLtpklN?=
 =?us-ascii?Q?EwaOnf/huus2D854TgXIABCbh6ZzOgkfwfX7QLip5prGsYWwA+ipmpzuzvAM?=
 =?us-ascii?Q?lZL165sIqNGyR9M7FYOPPoxM5t1ACyVOLfO/6iykPHuWLe4WYXw2vTumIHAY?=
 =?us-ascii?Q?lcnhLgGGhzxnkIKHqOqyOsR3sgsA7GQMIvz1TAegiNwOMDCd4ppKJkZuuuyl?=
 =?us-ascii?Q?sg48kSg3Im4659aryl+jjwsnvw5rBfBjUv4gRlgzkSN3uB50rhH+UZwXrVpD?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9D9AA1CF498064CB8B579CA06FB6759@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42baedc-83fc-42f4-68e4-08da6c0b5ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 17:55:25.0344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNdLn7KD6g+8QDj8UqtQoKCvBMevcQ0Ndurf30ipA0bSbacmwkD27lTKqyDmzoqoeSIjKTrNXN5M5Rr3OXKtYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220074
X-Proofpoint-GUID: A75UXSFn3w2XAcokHnk5G3ID1Kq5HXs6
X-Proofpoint-ORIG-GUID: A75UXSFn3w2XAcokHnk5G3ID1Kq5HXs6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 22, 2022, at 1:53 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Fri, 2022-07-22 at 13:25 -0400, Chuck Lever wrote:
>> There is just one unused bit left in rpc_task::tk_flags, and I will
>> need two in subsequent patches. Double the width of the field to
>> accommodate more flag bits.
>=20
> The values 0x8 and 0x40 are both free, so I'm not seeing why this patch
> is needed at this time.

It's not needed now, but as recently as last year, there were no free
bits (and I needed them for RPC-with-TLS support at that time). We will
have to widen this field sooner or later.

I don't have a problem dropping this one if you'd rather wait.


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/linux/sunrpc/clnt.h  |  6 ++++--
>> include/linux/sunrpc/sched.h |  32 ++++++++++++++++----------------
>> net/sunrpc/clnt.c  |  11 ++++++-----
>> net/sunrpc/debugfs.c  |  2 +-
>> 4 files changed, 27 insertions(+), 24 deletions(-)
>>=20
>> diff --git a/include/linux/sunrpc/clnt.h
>> b/include/linux/sunrpc/clnt.h
>> index 90501404fa49..cbdd20dc84b7 100644
>> --- a/include/linux/sunrpc/clnt.h
>> +++ b/include/linux/sunrpc/clnt.h
>> @@ -193,11 +193,13 @@ void rpc_prepare_reply_pages(struct rpc_rqst
>> *req, struct page **pages,
>> unsigned int hdrsize);
>> void  rpc_call_start(struct rpc_task *);
>> int  rpc_call_async(struct rpc_clnt *clnt,
>> -  const struct rpc_message *msg, int
>> flags,
>> +  const struct rpc_message *msg,
>> +  unsigned int flags,
>> const struct rpc_call_ops *tk_ops,
>> void *calldata);
>> int  rpc_call_sync(struct rpc_clnt *clnt,
>> -  const struct rpc_message *msg, int
>> flags);
>> +  const struct rpc_message *msg,
>> +  unsigned int flags);
>> struct rpc_task *rpc_call_null(struct rpc_clnt *clnt, struct
>> rpc_cred *cred,
>> int flags);
>> int  rpc_restart_call_prepare(struct rpc_task *);
>> diff --git a/include/linux/sunrpc/sched.h
>> b/include/linux/sunrpc/sched.h
>> index 1d7a3e51b795..d4b7ebd0a99c 100644
>> --- a/include/linux/sunrpc/sched.h
>> +++ b/include/linux/sunrpc/sched.h
>> @@ -82,7 +82,7 @@ struct rpc_task {
>> ktime_t  tk_start;  /* RPC task init
>> timestamp */
>>=20
>> pid_t  tk_owner;  /* Process id for
>> batching tasks */
>> -  unsigned short  tk_flags;  /* misc flags */
>> +  unsigned int  tk_flags;  /* misc flags */
>> unsigned short  tk_timeouts;  /* maj timeouts */
>>=20
>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) ||
>> IS_ENABLED(CONFIG_TRACEPOINTS)
>> @@ -112,27 +112,27 @@ struct rpc_task_setup {
>> const struct rpc_call_ops *callback_ops;
>> void *callback_data;
>> struct workqueue_struct *workqueue;
>> -  unsigned short flags;
>> +  unsigned int flags;
>> signed char priority;
>> };
>>=20
>> /*
>> * RPC task flags
>> */
>> -#define RPC_TASK_ASYNC  0x0001  /* is an async task
>> */
>> -#define RPC_TASK_SWAPPER  0x0002  /* is swapping in/out
>> */
>> -#define RPC_TASK_MOVEABLE  0x0004  /* nfs4.1+ rpc tasks
>> */
>> -#define RPC_TASK_NULLCREDS  0x0010  /* Use AUTH_NULL
>> credential */
>> -#define RPC_CALL_MAJORSEEN  0x0020  /* major timeout seen
>> */
>> -#define RPC_TASK_DYNAMIC  0x0080  /* task was
>> kmalloc'ed */
>> -#define  RPC_TASK_NO_ROUND_ROBIN 0x0100  /* send
>> requests on "main" xprt */
>> -#define RPC_TASK_SOFT  0x0200  /* Use soft timeouts
>> */
>> -#define RPC_TASK_SOFTCONN  0x0400  /* Fail if can't
>> connect */
>> -#define RPC_TASK_SENT  0x0800  /* message was sent
>> */
>> -#define RPC_TASK_TIMEOUT  0x1000  /* fail with
>> ETIMEDOUT on timeout */
>> -#define RPC_TASK_NOCONNECT  0x2000  /* return ENOTCONN if
>> not connected */
>> -#define RPC_TASK_NO_RETRANS_TIMEOUT  0x4000  /* wait
>> forever for a reply */
>> -#define RPC_TASK_CRED_NOREF  0x8000  /* No refcount on the
>> credential */
>> +#define RPC_TASK_ASYNC  0x00000001  /* is an
>> async task */
>> +#define RPC_TASK_SWAPPER  0x00000002  /* is
>> swapping in/out */
>> +#define RPC_TASK_MOVEABLE  0x00000004  /* nfs4.1+
>> rpc tasks */
>> +#define RPC_TASK_NULLCREDS  0x00000010  /* Use
>> AUTH_NULL credential */
>> +#define RPC_CALL_MAJORSEEN  0x00000020  /* major
>> timeout seen */
>> +#define RPC_TASK_DYNAMIC  0x00000080  /* task was
>> kmalloc'ed */
>> +#define  RPC_TASK_NO_ROUND_ROBIN  0x00000100  /*
>> send requests on "main" xprt */
>> +#define RPC_TASK_SOFT  0x00000200  /* Use soft
>> timeouts */
>> +#define RPC_TASK_SOFTCONN  0x00000400  /* Fail if
>> can't connect */
>> +#define RPC_TASK_SENT  0x00000800  /* message
>> was sent */
>> +#define RPC_TASK_TIMEOUT  0x00001000  /* fail with
>> ETIMEDOUT on timeout */
>> +#define RPC_TASK_NOCONNECT  0x00002000  /* return
>> ENOTCONN if not connected */
>> +#define RPC_TASK_NO_RETRANS_TIMEOUT  0x00004000  /* wait
>> forever for a reply */
>> +#define RPC_TASK_CRED_NOREF  0x00008000  /* No
>> refcount on the credential */
>>=20
>> #define RPC_IS_ASYNC(t)  ((t)->tk_flags &
>> RPC_TASK_ASYNC)
>> #define RPC_IS_SWAPPER(t)  ((t)->tk_flags & RPC_TASK_SWAPPER)
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index a97d4e06cae3..476caa4ebf5c 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -1162,7 +1162,8 @@ EXPORT_SYMBOL_GPL(rpc_run_task);
>> * @msg: RPC call parameters
>> * @flags: RPC call flags
>> */
>> -int rpc_call_sync(struct rpc_clnt *clnt, const struct rpc_message
>> *msg, int flags)
>> +int rpc_call_sync(struct rpc_clnt *clnt, const struct rpc_message
>> *msg,
>> +  unsigned int flags)
>> {
>> struct rpc_task *task;
>> struct rpc_task_setup task_setup_data =3D {
>> @@ -1197,9 +1198,9 @@ EXPORT_SYMBOL_GPL(rpc_call_sync);
>> * @tk_ops: RPC call ops
>> * @data: user call data
>> */
>> -int
>> -rpc_call_async(struct rpc_clnt *clnt, const struct rpc_message *msg,
>> int flags,
>> -  const struct rpc_call_ops *tk_ops, void *data)
>> +int rpc_call_async(struct rpc_clnt *clnt, const struct rpc_message
>> *msg,
>> +  unsigned int flags, const struct rpc_call_ops
>> *tk_ops,
>> +  void *data)
>> {
>> struct rpc_task *task;
>> struct rpc_task_setup task_setup_data =3D {
>> @@ -3080,7 +3081,7 @@ static void rpc_show_task(const struct rpc_clnt
>> *clnt,
>> if (RPC_IS_QUEUED(task))
>> rpc_waitq =3D rpc_qname(task->tk_waitqueue);
>>=20
>> -  printk(KERN_INFO "%5u %04x %6d %8p %8p %8ld %8p %sv%u %s
>> a:%ps q:%s\n",
>> +  printk(KERN_INFO "%5u %08x %6d %8p %8p %8ld %8p %sv%u %s
>> a:%ps q:%s\n",
>> task->tk_pid, task->tk_flags, task->tk_status,
>> clnt, task->tk_rqstp, rpc_task_timeout(task), task-
>>> tk_ops,
>> clnt->cl_program->name, clnt->cl_vers,
>> rpc_proc_name(task),
>> diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
>> index 8df634e63f30..60f20be4e7e5 100644
>> --- a/net/sunrpc/debugfs.c
>> +++ b/net/sunrpc/debugfs.c
>> @@ -30,7 +30,7 @@ tasks_show(struct seq_file *f, void *v)
>> if (task->tk_rqstp)
>> xid =3D be32_to_cpu(task->tk_rqstp->rq_xid);
>>=20
>> -  seq_printf(f, "%5u %04x %6d 0x%x 0x%x %8ld %ps %sv%u %s a:%ps
>> q:%s\n",
>> +  seq_printf(f, "%5u %08x %6d 0x%x 0x%x %8ld %ps %sv%u %s a:%ps
>> q:%s\n",
>> task->tk_pid, task->tk_flags, task->tk_status,
>> clnt->cl_clid, xid, rpc_task_timeout(task), task-
>>> tk_ops,
>> clnt->cl_program->name, clnt->cl_vers,
>> rpc_proc_name(task),
>>=20
>>=20
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever




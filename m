Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B6172A4FC
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jun 2023 22:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjFIUt7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jun 2023 16:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjFIUt5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jun 2023 16:49:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD02D74;
        Fri,  9 Jun 2023 13:49:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359Hn4Au019392;
        Fri, 9 Jun 2023 20:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zzvrDuwjiq8ys8I1XBB5c1pjGKVH06QNTqdKD8KSLSU=;
 b=YtPw9rY8idYK9YSvGkvfrTUUVo9FNK7NMPhjkNMlG0aYXzBbV+3v3y1hb/buoIOoJu/7
 RWtp0rN+0ZjlV2TzOXQwBQtwzTrDUM5wfMo5RrHwgp6fkwxufMqIr/mQQQkmauatwvBZ
 bSckhBL4aKCd9KbqgP0bi7f6+75lvkwLXe4OqD3xq7pm5cWtK8EEw3UmwNmuP/49RmQC
 oV+jxQNOyG3u1g+prGV8jEZQnMjcsenqHoCqrabx/B5zcTQXfw72VH2U5MZCCobSspyd
 HVycVjtHt2soPn1jc25gDXWAukuDSPDiE719t2AEq82WSuNFba8zDcM/Kjb3VxI5u/tq Rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rfmpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 20:49:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 359KXgxP010542;
        Fri, 9 Jun 2023 20:49:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6tp1nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jun 2023 20:49:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAyXk4OUuDRcZ+Jtp9uT6dl5je3CDEl+u082rBfOpQ5GPkMwLYKtgPkX10bfcUHLPEfc+6YI6yiApWBqUCwy+Pqx7ccUaPMkDBN2sg1WqVhH9YTCvFySkTeZ00UeXxyh2Eyp1tFVaFfc4npTB+nhRkM4t0HiWI/fjv4pjVqh4+kfd7E7GatUFV1PPKSu79nYg7cJrAIDPLenMY6NjnjsJ/CEUtTfNH4d8d36xlbJr0TFYwkKNDZ89Qij71hyR5efAGtRK0QshqU6M24DojKZWaqfJEUGLJT1oRr6vl+CrRex0iRmpJIIVacn/9IAfDilB12RI7OAVYWvq9vGdrQYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzvrDuwjiq8ys8I1XBB5c1pjGKVH06QNTqdKD8KSLSU=;
 b=BcYwYU/Wlr+iohKG7TFv0DcBBvQUFUF1BmWzJ/65jFYvoiIP2t7gU684oc3DzzYPhVQLA8dF9GPUJwa1cKWkcK+6G9HDRxhkelrS1ZvHdASWSvyggwhny/7nH8OB69bQ/qKHTyLm9geukPqgyT7a2AwbhDG1xzBlv54wqhm3WRk0yLOJwnK35wOYvAKosQyBZS38eFAdbR9BV8Gml3SZ70Rm3DDiVfhub3RMg8u5+UM8+/4vZPzxV11mnf/vphpDsTO1SyuU6SkDgVN/mwdAFDAwhzygIhnvEqlatIZz4MJAStgyABGzjOKup/Vsi8NDEWkydNTrVODaRDfHlfxlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzvrDuwjiq8ys8I1XBB5c1pjGKVH06QNTqdKD8KSLSU=;
 b=nPh+zCZ7wI0sET6GbOJV9jR5+XvaCmeE4uRZcAIBUMzdi/lF9LdZrKFePiGXg4Dnqy2zqV2vZF0gFNLmCH7QxGXw9qLRfjYzEjBT0tMZKbI1iQEZRaLAHh2tdQb6AWBuGqS8vIORlcyFskCCWCuPMf8BpbKg6wBv1ciQWZknB9c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6497.namprd10.prod.outlook.com (2603:10b6:806:2a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 9 Jun
 2023 20:49:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 20:49:44 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] SUNRPC: Optimize page release in svc_rdma_sendto()
Thread-Topic: [PATCH v1 4/4] SUNRPC: Optimize page release in
 svc_rdma_sendto()
Thread-Index: AQHZmJ0NA0ZICmeJcUqRKW78JwWSNa+C8XYAgAAFGgA=
Date:   Fri, 9 Jun 2023 20:49:44 +0000
Message-ID: <17F60F35-FA54-459B-BE48-07522D951675@oracle.com>
References: <168607259937.2076.15447551371235387735.stgit@manet.1015granger.net>
 <168607282316.2076.15999420482159168604.stgit@manet.1015granger.net>
 <7ae922eb-511b-f5af-04fe-f68cd5b19237@talpey.com>
In-Reply-To: <7ae922eb-511b-f5af-04fe-f68cd5b19237@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6497:EE_
x-ms-office365-filtering-correlation-id: f7a9d911-d077-4769-3dca-08db692b0e69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZOSb4jaLRbQa8nLi49JMV4JPoPP627atHXypYj6+agDtEZYslAlHSkrO4bClElEVJ7MSyaaTGHK2VbnshrXDY0h+oovd32RMjxvMc+Yl7XMlyQgWv6C2Xu2DWyhePtnkaolEMnFejrbCElPT3K1xxc9wGowy5vgbtMeC1xo9wqOFzzEwCA8+lWVxmcoZkoxS8tJAZM8yk7d+cpr/rCGjLPDCiEug+OzGxfLqtkUA+U9l/x3ITAegKpb6Phhp1VE77J1QphcmuF0wnIs/yUUfGLcylIXgpTw79O+4/5oDXs7Vr8MlXT7MxQglp41PHLo4/ZCf0bfGCqF7ozQ7Co3jCdp9IJzatRQvNokZKfejMjuweSTi/aTeVX1pjYXe2N8LYKK4E2LyRPt8VOBBBElCt4XxOlspKGyamqsDzHgYl1SPMtZFcBI6Y1lqcEYQ1a6dBKpJV240X59d//EUh1RIYwYyS6cDWT3JKhQ2/0JctZ+khXhiAR9nQDIie8mLtizQqmW79ZBuuw+2QOt2jbK8LxCSfQxwqE67zjOrQ75+SKJzVmOfALIt1G7lEzCAZND24DyP6zp1u7c41ACGZbutt5ZiQjsurwLtBrISH5xNQEd0Km3RldD2tO72vUgIn5itaHUyIQhOuOsY4SILmjaqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(316002)(91956017)(122000001)(38100700002)(86362001)(186003)(38070700005)(26005)(6506007)(6512007)(54906003)(53546011)(33656002)(478600001)(36756003)(8936002)(76116006)(8676002)(66476007)(66446008)(6916009)(4326008)(66556008)(64756008)(66946007)(5660300002)(2616005)(41300700001)(71200400001)(6486002)(83380400001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FTLmHDXuBv2Z1jIJye/TL42PaDmf362a+LLRfDZK4HNMi7b+AppnW5e4USKC?=
 =?us-ascii?Q?1r2EguM4tJ4/Z0IkghNnIA5bczIdaouyD6nX0wMTouFTJUUa3IlayLpnZv/h?=
 =?us-ascii?Q?wwRtwozkYRQkxeMCuGAcFxk+wdIjHX/yJyUvwxPVnqg3FOmn3lFuGj2U+z+J?=
 =?us-ascii?Q?DOGsVhsmU+GLS6pHBcf/75AXNNNCgt+FkuoLN8qo6pyyUUoujgFffXTa3WbD?=
 =?us-ascii?Q?C3ruyzjesQniSvSs9AzKCHTQwkEkm6KToOMGSW1S7srFdwAEgpnB/8kSOh+Z?=
 =?us-ascii?Q?lZfeoma8jIGnLECeyMGbv2+bxEl/Rq2vmtO48T25FO/cRfweHLVeVX73Ae0+?=
 =?us-ascii?Q?NmJzfBKPgOdi2OnCELuPgFSxrUiolaEp3J1xGoVu1FEA9d73VlWaSMbP4A3s?=
 =?us-ascii?Q?LTUj164aMJw+dzGn4j4UPAzkWEHnhTpjrLS7ZuOir5RP9WZAfLsiD9rWyy0n?=
 =?us-ascii?Q?Ehk3sEduE42gGoYF5pIuUXlJSci5ebNwazCOxDffrBw7+BsaD5kysFhhzznL?=
 =?us-ascii?Q?yg9wl5kg50ORQo18UbcOnsBzvqaEjFzxPxRDv3M/N9PV9aXILvvuKILU56xd?=
 =?us-ascii?Q?kc7Cy4wfPqeyjd8bo0Z/6u0MlbtlYHSY0LU1oZieRN4/o/nqsfWGBIhU5PKk?=
 =?us-ascii?Q?+/GuXtqHuowNMtWAdbU9y+ce0/18EvgR1D0O1IaDW1DwyFgpk0LZ0SRPpdWR?=
 =?us-ascii?Q?bLnbnvD6FdnoVF096o//AqOs4ZukdXuIF7547OH/gtGC1Oib0pWSQLKZrRyN?=
 =?us-ascii?Q?CSC2YgkPLHojEXTegLJ0AC1IooFpkFZPzywR6NAdZKzLz0ZDK9l7WR5z6dLG?=
 =?us-ascii?Q?Sk9Y0PcoTDOYfd2ti1A7ER8fNhtdymq00VTF2tFmKfPRpCuJCR+gnM7JxeHI?=
 =?us-ascii?Q?6S1o5J4Y6Gj+G3POsaWkz8VfIGJnSIkVs2qtoWnoA6QjbawAUagKIfqY7Csz?=
 =?us-ascii?Q?jqJgzrXGnThYlqeq8Srh7UnAcOC1r4HDjDXh82UEK+DuPjCliXWTcYnMsz/D?=
 =?us-ascii?Q?pVAhvEpFbNINZb0+cExcFO+EzT8MyF0VIlhG7/Sgepioj1jpfRLE0PGawrQM?=
 =?us-ascii?Q?DoIzfjLSi8q6qkKHxnIDwSaLw3vtsaCwiCyBbAxy2q5oZ5uW1wkOYj7klFG1?=
 =?us-ascii?Q?0hDHVCR+hAdVmKELA6L5KF7UEWqRL/vjFHmWqsv37rBFrdiIwK1YbNYxbSGY?=
 =?us-ascii?Q?gVug8sZYPlDk8sRT3j7SFSnqogFhJ1vjryR1h3xMSfW9rF0O5JXELhA6jde/?=
 =?us-ascii?Q?GtxYP/lSHlpd/h+oV/6iIbD9SJ4w50DIg5DYzTWG6LsRrmqvLJHM3NANEXCO?=
 =?us-ascii?Q?TCR4yVoEdS25VIHJLOxQI9e2gUQ/XKPR5603volhKvcidmpNNNUTV9BAbpsH?=
 =?us-ascii?Q?Cy+d9X0LQ10AYSE259ZgXPv7nAJO1Y39kDCa7FM1j4kupnqhNh9dvqMs+Bk/?=
 =?us-ascii?Q?Da5IzNSXyuacuR1fAFbO7CF3ZWbyebirwI1ivLoTrFXgU7FqXV+xSvGhmWnU?=
 =?us-ascii?Q?Ci9WmMQi0eWAoeZH+CAdb6NIAGlmIjR1+PzV3W23LzVXsW+/ETEerqrnh5C/?=
 =?us-ascii?Q?Pl5REOT3beMbsatk48LKo5gSN4ZdwaEL1sQd7x4nPGprrQ6VwvPHlVdAaZ3c?=
 =?us-ascii?Q?Wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B35137E6F659F24281A1DF6F8EB38787@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q18xlkrH9RxOnnQEniaJro6YUJ8OllPmpMHXLNOnQH3xqpRSyc+6uiBO6zUzkQ5XxBW0MVnbSmmbwi70pr3/NKhKJX2QUXzC898MS4bPQstPz8n02152LNvakeB2+QCQkz4mQbMdtUvn1NTI9n/VgprcLg6kO7SdST0bSJj9WqlxN0dmsRK9Cm/kZCuaoOgDA2v3XkJRsdoz9baL3d1Pt0x/QoicTx3zLbDqJdki3YLyl/tuTfVYdxJDnOxne2JNcC01IMXI4pDt1X4G0lZxCVRRIkRy96UtgQH9qhiR8Xvo7d/qLkGtpmP5CqF11r4skKTx+HUHBqhkg72LbXivwdSuRoRyTgChlyaRG9Tl9htBr8G2cHXmAJte0CjAQ7fzFwKo6dXeG/jReqEIirvc03Uz0j3XqzLwZU/zgnGnUpZ8RmtKSNoeOuPv0sOWdJOcnAx00maTl7iHP0ER2Hp0qZuP15MHt1d5FSIWR7iP/twemIKTz98CXOsVIC6xuytt/Yahcq0hqBhEMVNrQhQdMMePlxJewbNLkQAxi/oVHweQqtrNzcGwzUoWL4GgbgQDBiA5jsxs0GubgMpZRiCpi1anB/MjE7fTNnzFLNbvKK+J91eQdaKzK9LJ5GS+MrSlb2CPUGb37DLgSCEs8HArrxv0Y6YbllMdDKDjVtciETnaqotj3O+k85LamiacUjFMfvPBaPoM9VWpK8A73Dgbhqaqp5QqhFh6nkgLK55/+lCMgflI6hAWCzjjPbhLZuxV2s+NdzlGp9bAZ2qIbDsUVHSHdXsoTklAQUgL8ap3LsfaTLZSEPTtz31eCwLb3W4C
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a9d911-d077-4769-3dca-08db692b0e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 20:49:44.8780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZypubVFRCr9ej4NiS8XqpXxtDlFvKFkCvhurAy9TrrZfejOAQn1ZB7SguSztzRHS7qoQVUnUHo3wIpig4T+LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_16,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=826 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090175
X-Proofpoint-ORIG-GUID: 2HKhNuL2vcwW8a9gLNy8ZgNCxknCq2w_
X-Proofpoint-GUID: 2HKhNuL2vcwW8a9gLNy8ZgNCxknCq2w_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 9, 2023, at 4:31 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 6/6/2023 1:33 PM, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> Now that we have bulk page allocation and release APIs, it's more
>> efficient to use those than it is for nfsd threads to wait for send
>> completions. Previous patches have eliminated the calls to
>> wait_for_completion() and complete(), in order to avoid scheduler
>> overhead.
>=20
> Makes sense to me. Have you considered changing the send cq arming
> to avoid completion notifications and simply poll them from the cq
> at future convenient/efficient times?

That doesn't work for Read completions: those need to wake a new
nfsd as soon as they complete.

Send and Write completion don't need timely handling unless the
SQ is out of SQEs. It would be nice to move that processing out
of the CQ handler.

Otherwise, no, I haven't considered leaving the Send CQ disarmed.
I assumed that, at least on mlx5 hardware, there is some interrupt
mitigation that helps in this regard.


> Reviewed-by: Tom Talpey <tom@talpey.com>
>=20
> Tom.
>=20
>> Now release pages-under-I/O in the send completion handler using
>> the efficient bulk release API.
>> I've measured a 7% reduction in cumulative CPU utilization in
>> svc_rdma_sendto(), svc_rdma_wc_send(), and svc_xprt_release(). In
>> particular, using release_pages() instead of complete() cuts the
>> time per svc_rdma_wc_send() call by two-thirds. This helps improve
>> scalability because svc_rdma_wc_send() is single-threaded per
>> connection.
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/svc_rdma_sendto.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma=
/svc_rdma_sendto.c
>> index 1ae4236d04a3..24228f3611e8 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> @@ -236,8 +236,8 @@ void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdm=
a,
>>   struct ib_device *device =3D rdma->sc_cm_id->device;
>>   unsigned int i;
>>  - for (i =3D 0; i < ctxt->sc_page_count; ++i)
>> - put_page(ctxt->sc_pages[i]);
>> + if (ctxt->sc_page_count)
>> + release_pages(ctxt->sc_pages, ctxt->sc_page_count);
>>     /* The first SGE contains the transport header, which
>>   * remains mapped until @ctxt is destroyed.

--
Chuck Lever



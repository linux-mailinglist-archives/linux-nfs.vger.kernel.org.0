Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360DA6C38E9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 19:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCUSI0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjCUSIY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 14:08:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7166F37F38
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 11:08:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LGnWQN024693;
        Tue, 21 Mar 2023 18:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AK3xE4YywOpXPKAJIryS6EnclVTgddypkuZ4JrpCkUI=;
 b=bVSHv0Fq8d+jfOGywBstftHHB1XtIQwmW42Ohh5AEcqvOAYCn/VoW9XEsVjiYzuLCebr
 0UHCtsPTmp6e4D+CxU+bs94UMnusTM6LehsEQpBap1xHD4kNR39BCNExnxxLBLSnuxjg
 LWAvwaVhvFG1tcu098dihwI3o4HLDdIeFT9Hd4OZCQkSX7hkoyQdlVQSCXc94s9mIgc2
 K2LnpQjdoZeH/RIotNddEgj0Cn7rgkXBmoMJP0ZzXcm6Mm7hqT10TjV2QsfkEXfcqMOx
 aUF4hkrhEC6j84M6JAcNaUnb9Ig+Rc4CNjh1+wsPhby0EeGhQp/aAtSgCREqwmutz0kM Fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5uuey02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 18:08:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LHp0wq010388;
        Tue, 21 Mar 2023 18:08:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3peqjp6bcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 18:08:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qnvxf/H3oGJmtk9cJvQBQYxpqx4qPU7f2J/2lqAJst/5MDR6mxE/8nCwWj+Td/qshoTQ7r096Zu4kV/tFYVNkdO/DYS+nPArUtPF8I53ux2pm5ezYIDj5e5gQxfb6QPVOBFKARshzQTktbsfS/C3Y6mZ4DavwNb3+B5qGZKybN1BlOUTKBQgzDsq1Y7xlcTMo5YdnKzIQEpLQYKSRV8nHM5h/a5BrX3qxMNFO4/uhe9SrbPHWIqgGj0f1+zRrGV1xkbKIHt3R7JWfpove2VH+qTREADzGaRNkVYlvhQ/zxY09guhophhJierScScLhdBGtYXvtGGNNgOpERSRIYx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK3xE4YywOpXPKAJIryS6EnclVTgddypkuZ4JrpCkUI=;
 b=e4dSYwLfYOQnAFZk6SRDxl96WubIXPdYQGf7Xkd2vW100WyA+6qArsl9G65Ga+SoUc91Hw/cm9sYRHqZt4PV7pD4WnxEbY8hBu6qlzC6aAFGjYuayvoYufF+dv3LsIq0AU8x0ptk9MVnHjdvC31HXpRA55Y95MT8h2/wVD+oxKmjnq9aYPE/7tU8/oI2UhaBhvEAovDJ76wBqwGKYT6XRy9jAkIzhT7DrSW0jdleF9IunedMYYcMM9g39Z8R+V0STnlD1LPUBYw3fvIil8iZGu6N6gqUXjG9YzXc7FCNi/lfATMY51m2osYDZm3ndcmWG+CbaXgnMLiov6Jf/vWicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK3xE4YywOpXPKAJIryS6EnclVTgddypkuZ4JrpCkUI=;
 b=LLsESzr0WZqELA0Ho4h5EOYi8ZT1CmTX8/6Lt9YxggQs4lBKJXegjG22nqXRcrfKuVm8+zYdujyJSTpFyeIXOYtmagd2D0khDJRcOi9zKStXr/yZgDJxLyQJ0scmwwyHdqB6IUOIQrTwW9gK2fJc9A+mS/lYq3btI2k1RSX1LvY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5327.namprd10.prod.outlook.com (2603:10b6:5:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 18:08:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 18:08:06 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>, Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] exports: Add an xprtsec= export option
Thread-Topic: [PATCH v1 2/4] exports: Add an xprtsec= export option
Thread-Index: AQHZWzlIazFNUyn9IUyGBvjG1zIbKq8FIbkAgABn/4A=
Date:   Tue, 21 Mar 2023 18:08:06 +0000
Message-ID: <07F10068-A3E6-4C45-BB1E-F67FF4378155@oracle.com>
References: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
 <167932293857.3437.10836642078898996996.stgit@manet.1015granger.net>
 <b1da1fdbb190f50409f9fcd18b466defdfc04353.camel@kernel.org>
In-Reply-To: <b1da1fdbb190f50409f9fcd18b466defdfc04353.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5327:EE_
x-ms-office365-filtering-correlation-id: 716adbf7-3695-4ecc-a9cd-08db2a3738b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GK67/uLd9UpUsscWvlpS7Yxd+T/hhh4Skh9nRPFz2fkGihRj4dq5qDbaQvWmGIZJMLuiYh9CSS1aZ6vmZN41EYWEM0Kvbt+8p4vKmIjLuUg3Kazr1dXUz4MjFZIzrA92cD94VhH4hjlN1FIGv5EejWksCd2d1J5+LrUF0AfKVsvoYRkuos2BjqjzGvLja1Ow2dw34joyMOZH7fI4lFqmGyBxaPRM2PaMJebFyQ1giNRVQvtGGKXyEb1tcB8wW3O+Jq5hgFjO5228/JQYUZTyGluIMJw4ZuubQTFfasx52itqZ6QBieHAeX3jviVmwdNqfAn4ZdHGu0ZjfCqNZfSchTJ+LTyRtVCAzadAX1j7hRMXUg19/EUwwOrJiRR983P4M/hE+Gl2I74E3ttErLBp/eyNMCcvRPSln0gXsZlGh5NSpsRXg66qdTxUu0ml2+cvgBOIYvBVpljVG1DPqD9VUfCvXENLNivLzir5sgt1zjhDcL8X3NkrKPs30x+OX5l/1ZjPPnbhTa1COBhJYXgfumataxYEdachtz2tj1tZdUAkbvdfEOhpHabQbw4NNbGQijLhBY36GkZlcMh8ZLslEJGp1AxiruOzDERISsASN31Yxw/0vlQ2qgBwEJ6LT6DbaOHhf8KPE/EQY1SDbPNknF/dsrnQx0QdaIszIVrsE8a8G/CwLpjA/YxTsGA8n/C5BlMcrqkPBH/KbkPvo2aarbENiV9yKc/I/OJzkXKG6o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199018)(5660300002)(41300700001)(8936002)(122000001)(4326008)(33656002)(38070700005)(36756003)(86362001)(6916009)(38100700002)(2906002)(6512007)(26005)(6506007)(53546011)(83380400001)(478600001)(186003)(6486002)(66556008)(71200400001)(66446008)(66476007)(76116006)(66946007)(64756008)(91956017)(54906003)(316002)(8676002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1EX/o9EkBDpbEUcwgS8qCDE+vBCzgSpIFDeYZ3a4QmIUWB2lOG/G6MSMtEhA?=
 =?us-ascii?Q?igs7TUi8r3G48Z/yFPHSXENnaA1y6+arthGC87Kah1PsFAQOBFMzZz2Efuub?=
 =?us-ascii?Q?tjCut4wRZPiLJ4QLlUYonjYFwzitJLoS8nc4yf0akyuFLMtVOu9qkdiTH71e?=
 =?us-ascii?Q?6mxVRiDWnAfJsE5quWQM1CclfXRk/xnsJc5llKdP1D794Ybv8DrZq7PduE56?=
 =?us-ascii?Q?fDBjclcEEwn2/66X6eHlW0eL+Rvdm0lTT8eVKMEKVTNc0auekHaKecbSDse0?=
 =?us-ascii?Q?Z+E/Q4a2PJD8scc500YVB1ewkNaqgUHdF4CKMwkGG/9YhwxfrLCESKKr9IkV?=
 =?us-ascii?Q?O0+PsQ9sxTSOh7EQZsybBxiVZswKqEZ3efUsn8OkNUFi1fCL199nr5HJ4Uvj?=
 =?us-ascii?Q?nm1yTj7qvFI/tX/CBgyvcJbnJ/GSoNaQPz3+HBRLXz/t502Z8ldWcq+ZeMMJ?=
 =?us-ascii?Q?QYUkhzvM+i3D6Irky89LwYW2kGYTIvlSdLa+54wjLDlRUzhh5PlheZAeDTpr?=
 =?us-ascii?Q?Yha/tevvp6nFmYmqc8jV+NtodBo6GmzupxDWQCBXUXYTxJTqTmR3ILqC8UGf?=
 =?us-ascii?Q?PF5w9epZhH5tFZlWK42DBWtUpLz5nSkq06QCcyIZrbW76YtOTIRWV1Dgkuie?=
 =?us-ascii?Q?z4skR2BOPvFyfxtt7GceUOdcs4Yo5zY/ZDhDXhMMz/iv5ksKTRyucb4AwqeP?=
 =?us-ascii?Q?Pihr8oy0nTPCFrWbDHU8CDjA0Nvq7ZclLo7KuasCPtXKu0ZhDp4oocfnTpt8?=
 =?us-ascii?Q?DyMnLi7V6fT5yNdOER2HC2UbU3pLXB9xJSqZxQwn/ngBSnbnkZcI1/158ZuO?=
 =?us-ascii?Q?L36IamsEZQlwZP1HkbW7xSi+4b2ojrzjO12AthbFye4PCQK09g4X9R8M0MuK?=
 =?us-ascii?Q?oKOLT8mO5xbtK+cGRRMd6FKaajoLhsvqewkoBY9+xqOwsF2r86yF5Um8CM6B?=
 =?us-ascii?Q?lr0chridV+VRY8CvZDOa9mEbymWPWtNcs+QV6h8xQbOgn07x0zIU315TxslC?=
 =?us-ascii?Q?UdXofgSH0NGZT5c4DYdyUdmbA2HzalKhmoWH7bbI0sT99R0Hgi5fS3U3Z6eQ?=
 =?us-ascii?Q?+FTzXzIiCZPP3DoQWH0BraMFixKUic/4KaWUJOHOIBOKrjZT3QiNVn5MP0WQ?=
 =?us-ascii?Q?8NPGP+REZGBHq/sQkoU1tJpnjfO7yn7ctKzmLA6XCy2EGx2GMSWymUdKHvIY?=
 =?us-ascii?Q?TgxS7HOSL1xJurgupkmZN2gFnZQ/lXqchTM8uFDJoMiELeNLezsftlo8DU99?=
 =?us-ascii?Q?Vt8zw4+E50Yr2LG4iw1ya9zH/59pLCdOEA/K+7rOE/4JGmoHxS0fd6tqky6s?=
 =?us-ascii?Q?fezAVBSzS0+Tb4iJ+XgjQBfGwUfZViXuJca+p35A9XTED6Pz2YuqTnFSAxvd?=
 =?us-ascii?Q?8wSITnwS8agLjhuGZGVdOu9HNA3HdRGoaFEz+4TWGgYeeJry/HeOca31pREk?=
 =?us-ascii?Q?PY47W6CPoLkFPywnpXYREsjRnDIyPEoHeH7FbBSeuBIXcrdOlFB/5K3eo393?=
 =?us-ascii?Q?KJ4C+pfRzjqozAvK8V8M1UPm/u7LCMIP36paUVZhlnLJksdDcXorfMQxZcmH?=
 =?us-ascii?Q?IXpJk+PbuuvjqI5t/m/L5ZVTNsFcu0Uk3973WHid1Lj6VzNWKvdQlTnlhEIm?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2091B908BFD8C44EAA37319E7BB3F947@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WoY78cn3YJgrJoOeNIu2boJvyLKDulbpH7RLl4dGJw6F75NsQEmr3Fk9TXp3xBf7e93q/YlTskdtxVyPHHJHo1tKkcOXb/8lh1DY6QY2nZrkDWch49AKUsstFGdHKVr8NfDJ+WJIru0eQMgTr1oegD9XMyJpEg/0uxI7WWpyfEFvI98YTWPD31RunlYU4C9bO97hP6LdXuksdHon6C2ogXLiXB/7uleWUeqkDavkx+3aE7bFhWlpWy6NMjZCdACSzn6xmOjFjK4GSeQ6puYBQyDwwaorBuHnKZ5iOvbik1CweWXOCVqLkRts54BByUERS2SqhSkr+8hPb9Pb+OpyemR+8yr7xQX3eobKWndpThuSg3m7TUbF4LisAzJWzT06MtJvl1LXHL4CkNClIdgb4lTFYv4msw9GpL7LLglYjl0RB3M5FFacSfjnl8U0ClX3BlNMLthMoZlSZF5EHAScik8cn7pCEd2QilFupRxNGiLZ9SmV0OVTkHv7x3NSwAbQ/h8sit0x8rqY81CJqt8oQ/PosePAbGc6bxEKz1iOlUIZ7DCc8F+DaPNfnryUXUKjHlUXkunatO/LcfAl0h94a8aADWlMBoj25vun3Q+V/eAUq39wTvQ2IEGhAxVx1zjw9zvXterDrdzbC9INDXD5kjpTyLUaPhUxfmXBH/7sXQrargYuxQ2G8LRT6Ku6eNGs+h9E3MPdqiBLoc3Modsnvw8GzGX+3yp0yfmOr6Z4yzEi1b/dns13UzjQfq8Ki2s4ax/KSAigqyc7kMTQmepDQHzeQ1kLBrxdnqPlC7U4TErcq55yY1+dlWwFozEdxFty
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716adbf7-3695-4ecc-a9cd-08db2a3738b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 18:08:06.5767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uk6L04HKeMaqqbwtfuReGmQojWyQbgpLkTX5a4cdUZNDwifFVwROEv2OOPPvvd4gXgqPeeYsbVbVcMGcTyVBnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210143
X-Proofpoint-GUID: Knck-J6uvahIrzdjyG5oy3uPFscS6-Hu
X-Proofpoint-ORIG-GUID: Knck-J6uvahIrzdjyG5oy3uPFscS6-Hu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 21, 2023, at 7:55 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-03-20 at 10:35 -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> The overall goal is to enable administrators to require the use of
>> transport layer security when clients access particular exports.
>>=20
>> This patch adds support to exportfs to parse and display a new
>> xprtsec=3D export option. The setting is not yet passed to the kernel.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> support/include/nfs/export.h |    6 +++
>> support/include/nfslib.h     |   14 +++++++
>> support/nfs/exports.c        |   85 ++++++++++++++++++++++++++++++++++++=
++++++
>> utils/exportfs/exportfs.c    |    1=20
>> 4 files changed, 106 insertions(+)
>>=20
>> diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
>> index 0eca828ee3ad..b29c6fa4f554 100644
>> --- a/support/include/nfs/export.h
>> +++ b/support/include/nfs/export.h
>> @@ -40,4 +40,10 @@
>> #define NFSEXP_OLD_SECINFO_FLAGS (NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
>> 					| NFSEXP_ALLSQUASH)
>>=20
>> +enum {
>> +	NFSEXP_XPRTSEC_NONE =3D 1,
>> +	NFSEXP_XPRTSEC_TLS =3D 2,
>> +	NFSEXP_XPRTSEC_MTLS =3D 3,
>> +};
>> +
>=20
> Can we put these into a uapi header somewhere and then just have
> nfs-utils use those if they're defined?

I moved these to include/uapi/linux/nfsd/export.h in the
kernel patches, and adjust the nfs-utils patches to use the
same numeric values in exportfs as the kernel.

But it's not clear how a uAPI header would become visible
during, say, an RPM build of nfs-utils. Does anyone know
how that works? The kernel docs I've read suggest uAPI is
for user space tools that actually live in the kernel source
tree.

I think the cases where only user space or only the kernel
support xprtsec should work OK: the kernel has a default
transport layer security policy of "all ok" and old kernels
ignore export options from user space they don't recognize.


>> #endif /* _NSF_EXPORT_H */
>> diff --git a/support/include/nfslib.h b/support/include/nfslib.h
>> index 6faba71bf0cd..9a188fb84790 100644
>> --- a/support/include/nfslib.h
>> +++ b/support/include/nfslib.h
>> @@ -62,6 +62,18 @@ struct sec_entry {
>> 	int flags;
>> };
>>=20
>> +#define XPRTSECMODE_COUNT 4
>> +
>> +struct xprtsec_info {
>> +	const char		*name;
>> +	int			number;
>> +};
>> +
>> +struct xprtsec_entry {
>> +	const struct xprtsec_info *info;
>> +	int			flags;
>> +};
>> +
>> /*
>>  * Data related to a single exports entry as returned by getexportent.
>>  * FIXME: export options should probably be parsed at a later time to
>> @@ -83,6 +95,7 @@ struct exportent {
>> 	char *          e_fslocdata;
>> 	char *		e_uuid;
>> 	struct sec_entry e_secinfo[SECFLAVOR_COUNT+1];
>> +	struct xprtsec_entry e_xprtsec[XPRTSECMODE_COUNT + 1];
>> 	unsigned int	e_ttl;
>> 	char *		e_realpath;
>> };
>> @@ -99,6 +112,7 @@ struct rmtabent {
>> void			setexportent(char *fname, char *type);
>> struct exportent *	getexportent(int,int);
>> void 			secinfo_show(FILE *fp, struct exportent *ep);
>> +void			xprtsecinfo_show(FILE *fp, struct exportent *ep);
>> void			putexportent(struct exportent *xep);
>> void			endexportent(void);
>> struct exportent *	mkexportent(char *hname, char *path, char *opts);
>> diff --git a/support/nfs/exports.c b/support/nfs/exports.c
>> index 7f12383981c3..da8ace3a65fd 100644
>> --- a/support/nfs/exports.c
>> +++ b/support/nfs/exports.c
>> @@ -99,6 +99,7 @@ static void init_exportent (struct exportent *ee, int =
fromkernel)
>> 	ee->e_fslocmethod =3D FSLOC_NONE;
>> 	ee->e_fslocdata =3D NULL;
>> 	ee->e_secinfo[0].flav =3D NULL;
>> +	ee->e_xprtsec[0].info =3D NULL;
>> 	ee->e_nsquids =3D 0;
>> 	ee->e_nsqgids =3D 0;
>> 	ee->e_uuid =3D NULL;
>> @@ -248,6 +249,17 @@ void secinfo_show(FILE *fp, struct exportent *ep)
>> 	}
>> }
>>=20
>> +void xprtsecinfo_show(FILE *fp, struct exportent *ep)
>> +{
>> +	struct xprtsec_entry *p1, *p2;
>> +
>> +	for (p1 =3D ep->e_xprtsec; p1->info; p1 =3D p2) {
>> +		fprintf(fp, ",xprtsec=3D%s", p1->info->name);
>> +		for (p2 =3D p1 + 1; p2->info && (p1->flags =3D=3D p2->flags); p2++)
>> +			fprintf(fp, ":%s", p2->info->name);
>> +	}
>> +}
>> +
>> static void
>> fprintpath(FILE *fp, const char *path)
>> {
>> @@ -344,6 +356,7 @@ putexportent(struct exportent *ep)
>> 	}
>> 	fprintf(fp, "anonuid=3D%d,anongid=3D%d", ep->e_anonuid, ep->e_anongid);
>> 	secinfo_show(fp, ep);
>> +	xprtsecinfo_show(fp, ep);
>> 	fprintf(fp, ")\n");
>> }
>>=20
>> @@ -482,6 +495,75 @@ static unsigned int parse_flavors(char *str, struct=
 exportent *ep)
>> 	return out;
>> }
>>=20
>> +static const struct xprtsec_info xprtsec_name2info[] =3D {
>> +	{ "none",	NFSEXP_XPRTSEC_NONE },
>> +	{ "tls",	NFSEXP_XPRTSEC_TLS },
>> +	{ "mtls",	NFSEXP_XPRTSEC_MTLS },
>> +	{ NULL,		0 }
>> +};
>> +
>> +static const struct xprtsec_info *find_xprtsec_info(const char *name)
>> +{
>> +	const struct xprtsec_info *info;
>> +
>> +	for (info =3D xprtsec_name2info; info->name; info++)
>> +		if (strcmp(info->name, name) =3D=3D 0)
>> +			return info;
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * Append the given xprtsec mode to the exportent's e_xprtsec array,
>> + * or do nothing if it's already there. Returns the index of flavor in
>> + * the resulting array in any case.
>> + */
>> +static int xprtsec_addmode(const struct xprtsec_info *info, struct expo=
rtent *ep)
>> +{
>> +	struct xprtsec_entry *p;
>> +
>> +	for (p =3D ep->e_xprtsec; p->info; p++)
>> +		if (p->info =3D=3D info || p->info->number =3D=3D info->number)
>> +			return p - ep->e_xprtsec;
>> +
>> +	if (p - ep->e_xprtsec >=3D XPRTSECMODE_COUNT) {
>> +		xlog(L_ERROR, "more than %d xprtsec modes on an export\n",
>> +			XPRTSECMODE_COUNT);
>> +		return -1;
>> +	}
>> +	p->info =3D info;
>> +	p->flags =3D ep->e_flags;
>> +	(p + 1)->info =3D NULL;
>> +	return p - ep->e_xprtsec;
>> +}
>> +
>> +/*
>> + * @str is a colon seperated list of transport layer security modes.
>> + * Their order is recorded in @ep, and a bitmap corresponding to the
>> + * list is returned.
>> + *
>> + * A zero return indicates an error.
>> + */
>> +static unsigned int parse_xprtsec(char *str, struct exportent *ep)
>> +{
>> +	unsigned int out =3D 0;
>> +	char *name;
>> +
>> +	while ((name =3D strsep(&str, ":"))) {
>> +		const struct xprtsec_info *info =3D find_xprtsec_info(name);
>> +		int bit;
>> +
>> +		if (!info) {
>> +			xlog(L_ERROR, "unknown xprtsec mode %s\n", name);
>> +			return 0;
>> +		}
>> +		bit =3D xprtsec_addmode(info, ep);
>> +		if (bit < 0)
>> +			return 0;
>> +		out |=3D 1 << bit;
>> +	}
>> +	return out;
>> +}
>> +
>> /* Sets the bits in @mask for the appropriate security flavor flags. */
>> static void setflags(int mask, unsigned int active, struct exportent *ep=
)
>> {
>> @@ -687,6 +769,9 @@ bad_option:
>> 			active =3D parse_flavors(opt+4, ep);
>> 			if (!active)
>> 				goto bad_option;
>> +		} else if (strncmp(opt, "xprtsec=3D", 8) =3D=3D 0) {
>> +			if (!parse_xprtsec(opt + 8, ep))
>> +				goto bad_option;
>> 		} else {
>> 			xlog(L_ERROR, "%s:%d: unknown keyword \"%s\"\n",
>> 					flname, flline, opt);
>> diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
>> index 6d79a5b3480d..37b9e4b3612d 100644
>> --- a/utils/exportfs/exportfs.c
>> +++ b/utils/exportfs/exportfs.c
>> @@ -743,6 +743,7 @@ dump(int verbose, int export_format)
>> #endif
>> 			}
>> 			secinfo_show(stdout, ep);
>> +			xprtsecinfo_show(stdout, ep);
>> 			printf("%c\n", (c !=3D '(')? ')' : ' ');
>> 		}
>> 	}
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554C84C7872
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 20:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiB1TFQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 14:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiB1TFP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 14:05:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD719A9B7
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 11:04:36 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SIJ3KF025516;
        Mon, 28 Feb 2022 19:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=X1iic6HLo8t/UDrOCuZw25tDx5pgR+c0i4cldK1fG2U=;
 b=u9qHrrOjB6tAhKVpqkrit3+v2SaXX5ziZUJVWxeZd3kpqZjrhmRFTOuHytYB8En6oavO
 NWf+hqd9BxWyKzGSYuWigbEIAcUvdqqIbv9ZF9/KOdlO7EFjMLw60y7t5bYBkzbqxojh
 ow+afYp2JpTOQf6XLQVOEgD56xMJVK+M243Kh4phtCa5GSxnxobeTqeSlvkiOT0tqkkF
 yaj+8r/FanXVeUVEZ6AGjEF6DjPWuNOKtM9Di8OF0VhEnZ3T1T1TSZHq7rWLPTxMD473
 88I/qnLmkgiFpazAZTlIViPxXkyr/1o0YuBMQaXgTDGmqoBCIgIeLIZoM7Yb/8vr1App Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efb02nayr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 19:04:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SIjGLA192981;
        Mon, 28 Feb 2022 19:04:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3020.oracle.com with ESMTP id 3efdnkdsg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 19:04:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fw+uqTXkJx/B2OjCq6NXUXYUwrhJ1ogj+2+aI+jbjK7pU0JOKTUApCFP1VLBNaFryycY26ArqqGAFl8X1JIKMSek7cLMsB+iW0gWtx7R0B4BqSC8vnsUzcvzf1/h02ChZO5XPzOq+jlyS9hg7o0XPQqyQWBqtr6pkLOdVe+nWMTIMakkn7ebo25sL1ZwpIx4LfFYZI5MqUHgcXVVoojibHzwBK63mepGbd9W+oVw7NBAayL9/bdo/3stV/Nbozc+s9kYN9qHKaS2Zv163pZUHvIh/XYZjwKljehEOOx4WQDA8ZkfLrueFxrMjlYmTAyPV0ddUFoDgNstcJJ38qYE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1iic6HLo8t/UDrOCuZw25tDx5pgR+c0i4cldK1fG2U=;
 b=QmTmB7lvlk4UotgOH1ewx96nJoCE8YSWPTpq33aiLZw23A4kfwRFoXuB1nDMDlxU+Y/AZ1WLRVyxPvDmwa7p8TUB5VIWjPf8SWG8aa+a38TsYcvNw87MI10/VpKPiXswSsOhab2hV1sJqfhDuKgDRb2rtbMMKCg7ruHiroSV6Tk3idDQAVVzj3QXBJLS6WqYxMiHUL/xTy/PUI4Wv7f/5zCe/Mq6p1NwCIzy/XPbuzNnm6V7P+BS4k1vVVVFTpx5T7iGbgKmoFvhK+hJEFtgeVwNtNNdIuhhGcYx5GuOdT4D1Qo4i4szdOSlwxKmsh9SBc8cyjVIDHH/FJ5IyPDHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1iic6HLo8t/UDrOCuZw25tDx5pgR+c0i4cldK1fG2U=;
 b=KXlS0MNSFftY43RVglKlJfCBQxXvY4hcwptLxe/BBy470S9Vgrme9roX6Sf5h4uJHoxXmQOToe8btJPb3Z3iDRf160otxnW0GCMbXQGtvir8ZFbfuWc/ziIJNZSLQ5uwy+T6gEEE3LJeAN3Um97MUyPpEWl/Banj+uq6NwSgKpk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR10MB1514.namprd10.prod.outlook.com (2603:10b6:3:c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.25; Mon, 28 Feb 2022 19:04:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 19:04:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "bcodding@redhat.com" <bcodding@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Topic: [PATCH] NFSv4: Tune the race to set and use the client id
 uniquifier
Thread-Index: AQHYI1yJP7y4xU9Y+kaLua2/7R9GAqyXsraAgBGBCwCAABW4AIAAG9GA
Date:   Mon, 28 Feb 2022 19:04:27 +0000
Message-ID: <F853D68C-C066-470E-BCFC-988C3D46ABA8@oracle.com>
References: <61a5993a1f9bbed2ba1227bd3376e92232e0530a.1645033262.git.bcodding@redhat.com>
 <3EA14A5C-9FF9-4DDC-B530-768A86E2A4E8@redhat.com>
 <0F8CD466-6233-4386-94C5-FC8E5941F9D3@redhat.com>
 <73b61ba083df0a8954979fed11d6398d336ee1d1.camel@hammerspace.com>
In-Reply-To: <73b61ba083df0a8954979fed11d6398d336ee1d1.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8276074-85a9-4ba4-8018-08d9faed24b2
x-ms-traffictypediagnostic: DM5PR10MB1514:EE_
x-microsoft-antispam-prvs: <DM5PR10MB15144450764DE5989850125B93019@DM5PR10MB1514.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CkHnwAcTEKLAySVJqRfGJ0Gjn8X33zUQk/bOc0oskxvY1969o0lzLfj7eI+9dBS/r+OFriZgt43YkQjbU7A92QCet2mz438Cocv0xnCLJNwUeNrix56WTY0EepRDEPIXpeJwStXDoRwDIWQTQ29RlIIwvVkVcBGe5P5LyFHTsg2pkDbhsJ6/PAdl0u3v0UC5jzU3lpxlS8HCohwzDWP1TYwFTnB3pYHMYg7Ezr83qsz5IU+yBCH8NJbttnw7EOC9LSKDa+m00Ndv8689WhOvF2EsD1hdw8FrsnHnZpHgS/b8jU/tMbZVwsRZ04Lu0p0nsxJRDDJ5vAoUg7Ee7rN3HClS263oJcIbsuWxBf8Sk58rGaAVVKz0W4Uxc55V4Y2v41yO83ya/XdKFj6NzHMVLMOLRt9dKbP3XszjeCZVSpDyMhSf2cJWfwkV/e2aBn2MUgF2b/ACt+67jaA3+dgE4SVH08TxL5exMO35GFU9wVIvma9UKH99ZZ479DxrTrtqgRBg9JO36F5DrOd/GsO8pVVyZDx60j1nqxyAUaxoxsa3lbGSEUxw8x7qWkd35e2bYMSpXDUKNr9kdyjDnHx7CrpTeuoZoDx3xBPDWf0WtKZpM6VIMeoBjWeJUcZe8O0SuAgsY5wXj5PalzLANqPBRn+iD30SWCR14t7TPR04r4OUsE7VOd2CbvWjP1vBEsDM7yb4jZ8QtlL4Ezw0YCj7nBkJpfmpBhp/Nv6L6A5N+6w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(122000001)(64756008)(66946007)(66476007)(66446008)(66556008)(91956017)(76116006)(38100700002)(36756003)(26005)(4326008)(186003)(83380400001)(6512007)(38070700005)(2616005)(316002)(2906002)(71200400001)(8936002)(6486002)(33656002)(54906003)(5660300002)(86362001)(6916009)(4744005)(508600001)(53546011)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3pc3EGUIy/yJxQ6awbTb+vszQMvGPc8lujsFEGkJdOQXoFEV8N54nUEIOVqN?=
 =?us-ascii?Q?MWmIQWTEryHFRNAvn3rglxHTUM+UFnCJK2RhhPKUbPzClYRFPv+lUUEN7fy1?=
 =?us-ascii?Q?HgaHZONv+ArkjaOx2XqSdxHUMTl/bciHzBYlxsAjIb0kns3v0PRO42lPAYYY?=
 =?us-ascii?Q?tnZQf2MKKRnkH4NMZaZhtg7Gq2m4p32L0mBFqZKdXHCiyMSre8kkjR1F3bQx?=
 =?us-ascii?Q?unvQ3oN7vpHfafFytJHSdIIha9I3hWBK6TZYNJmcu7zkNZuzxLV7LfqnteGA?=
 =?us-ascii?Q?M/xWkaMFS1AL2U4cyDXpatq+k6rsABq92UpH49rDbStX6aJSBt+AVNIJjjTm?=
 =?us-ascii?Q?KWERLp4fw75XZW9Rl0BgG6+Dg7Ps55x+KeoUaVXo7qF+OQwEEU6r/zzgoJQK?=
 =?us-ascii?Q?69i2T4V2t/R+/xlbcG4GvwXowcz+ZC2PRVZKfXm6iJmLQ+i7/8VuHJfXni1l?=
 =?us-ascii?Q?i4yVaOi2K07aXgWZXjsgNhTEyEttXWI2+8T+dlZWHo2/RdeI4n1t8riypdd0?=
 =?us-ascii?Q?cT6PCxqNsfgCvsGjAK2k//GH+csI9b13xLx+4hZJDhDM4mxd6v68PwfdJQ8Y?=
 =?us-ascii?Q?2sxroiZF3sso1HomAcOxmt+edXgGGoiM4wXR4R4sewCyJ1/gkTYrdOUFBns1?=
 =?us-ascii?Q?2Y8v9sHK0EncEVmjq1nxosDC6eZeLKMkZJR/DLCK6WWJM7V2piuvBFvJVWAG?=
 =?us-ascii?Q?a414sDAuh7SRueTOEIUltW/uPiaFrRXXKywOrb9GVplTijaeQta6Hl+fTmtC?=
 =?us-ascii?Q?w4K/KqWQ/cgiaSs2ty4VVzuWn8MwY1kvG7yEYlElmSTaEWIXB+PuzBHBh5za?=
 =?us-ascii?Q?fYZzcTJkSM8WmrA2GsyAR6BHu69gMUIuxGuXyakSoD4wFw1/YC1W7q4KciXb?=
 =?us-ascii?Q?4ZMRzJjTJQfoxu7gQ20UkaYMckzKAYo6d/+vc38OBgmH86xRN+fgUzirrEZj?=
 =?us-ascii?Q?62qNLB6PWyEUDe5z88Fbc5KgQTzjkrRxpuF6O9yg6j2kM3mZEXuD1SMRinJb?=
 =?us-ascii?Q?CgSsVXWEFlNW8QH9EmVWymkOpXStX6kGRAlGHWxMvD8EI53947huvt9HzcRY?=
 =?us-ascii?Q?xk3BFpckI13e5ucT/t3M17KQNzun3Hfenhw4SpOE736MMKK0Hpm6nW9BfHm9?=
 =?us-ascii?Q?sS11LJHz9njDgEP2sKfj3fi/dG7YmkLRNBp/i70CKwq9GzdDYKJdqWxS+WuW?=
 =?us-ascii?Q?C63rBOgswM6VwCd0hKRuguuwt3pAKxNau9DcehEhvKTC3sarhil0EOny+8nr?=
 =?us-ascii?Q?FvqFWtaGLfruBpWNDTI+PD83i8SQc/kxGJ/RpPn9JQZsPcmgAni7bNldAMbj?=
 =?us-ascii?Q?HaZsM1b9NiJcAuFj4VIB7l4u4qk66CxBxgYH3GrXm9moWYEVxjhmLdKTFiQX?=
 =?us-ascii?Q?mSY434tcDYVxlWdWMFoaeAYIfuBZ+nbEFyu2mMN6uMkpbS6cvvNEveB5P/Fc?=
 =?us-ascii?Q?GoOCewk3yKr8MC8TfyvfjobXrz4ddh8Pjm2iKJ9FYYc5cIGZC2m1vpuw9AHD?=
 =?us-ascii?Q?DtgqF4WS8WBYBuFcFZsu2Lb+eY60nVtUDhPd8AjrhbnRjNZe9CjOA2PKHqjd?=
 =?us-ascii?Q?BQGajwoCRu8wtzrPEjGX30Kf4UgXu/Iq9QN3Zwf7J196ONKn+8NPC1JQEk7i?=
 =?us-ascii?Q?Rey5MrAPwuVEqz/qok3l5K4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B5E807653D34B4F8FAB80C50CD96DC1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8276074-85a9-4ba4-8018-08d9faed24b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 19:04:27.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTJh+Jc/k2iCRN3Qo7mUALrd3fsSho3zFY4LZqb6B8XictRZCmQ7tvJ0EluuaVriuKlvCQAO5GwvHAIAtRmg6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1514
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=856 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280094
X-Proofpoint-GUID: Rx3q44izhE4g5xT3Tf8BEe8Gg6OCXHuW
X-Proofpoint-ORIG-GUID: Rx3q44izhE4g5xT3Tf8BEe8Gg6OCXHuW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 28, 2022, at 12:24 PM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
>> Attempts to work toward solutions in this area seem to be ignored,
>> the
>> questions still stand.  Until we can sort out and agree on a
>> direction,
>> self-NACK to this patch.
>=20
> A new mount option doesn't solve any problems that we can't solve with
> the existing framework.

I don't think a mount option was proposed. Rather, the mechanics
of the udev rule would be done by mount.nfs without any changes
to the administrative interface.


--
Chuck Lever




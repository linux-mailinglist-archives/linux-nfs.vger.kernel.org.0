Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADCA6E5426
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Apr 2023 23:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDQVxq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Apr 2023 17:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDQVxp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Apr 2023 17:53:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53882D60
        for <linux-nfs@vger.kernel.org>; Mon, 17 Apr 2023 14:53:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLTb21004053;
        Mon, 17 Apr 2023 21:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kNOcYgcuX2VE7p2FGq0tc88FgEu1btsrQkRHXDVmP14=;
 b=qMn1dyRzhacVm+0pjdMI70csx9YQsRIvrl4X6faXRPLzCfI9GW4ShzYVVl4GVSIIjKMi
 2MDNsWRXqRzQLsTRTkbUF48MzLZPaFhebINJ2DaUbFi57caZw0e88ubtCcbNbSfZ2gEW
 JZoqAAlyauKehyoL5eGLTiTR9G8Ttwqi8mKWA8V5uPLpE3Gg1tiMLbNjy2kxr8Dvmkzp
 0Po+KnWXeMdSTMq9ybqQl0N2FiQGyPlcFXjZ4EQ7qStNnCWb1RN/UjsVv5PYlfMrywAD
 04pWpJi16qKmd3vgGRGBJS/vxsqu0eWWjxmI5UHrHRnVGrkqNHFeDmrwCZhYhVL9/52U 8w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyktam7fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 21:53:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLeIU9017500;
        Mon, 17 Apr 2023 21:53:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcaynfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 21:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwYCoCmttzMV+Pno/51xGI5cRW+OVKMnRZr5bkKu70r+STVIekQlgmvoBjbUKWE2TT1xnMnXvI8Fbc1qrgFEsMdaHNDfANNin8wzTAxoXaWonph/Kz1R5hCTVbP4UeXPVfMQcCDP2oWNL8dTE9CQBlcr7SzJVo35CssXPQsEetuSs90P7lOTfudlQA9mG6tuSt1UuJK28lznNMV7JG3YxORJBdIJFrS3dK+Pk30OYtIkwZ+c6ovqw0bf/FxIQ84WA9WL3h99TCtelchk1m2ZtigpztfnQJ/yJciKxlODDnbmaFU5JMbcd3D17jF6q0ugSptKGBEWYVfq6fleuVvhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNOcYgcuX2VE7p2FGq0tc88FgEu1btsrQkRHXDVmP14=;
 b=Hnzn2Ti523GWuDgbaVwiCec+TjExB0ypT1ywUtLM8EmmQ24fTk60NlnH7l0fcxAGaUAVW+4zwzbSY13dRIPvFBJCrBzA7cmDp3P9Bd6jb94Yrph37FRbKrPKnyk4vrq33nLlFcySEBZ9kiAWitPqAeObCNIwWOgpGgwL19R1Bly8uBM6t6CrlliiYzp7yBjKoRp4YR8iQockNG/tx87MyuWdGGfqE679kYsc5ORGf8S3Bsz0oAEJKLOaOF+QTIU03KdFP9FF2wzvhwC54KLH5JfnUQblclCGPve2p/xTblAqSfwODHqwYYhlfB7vOhV46LL7Z2jQTEa6Z91VrD+3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNOcYgcuX2VE7p2FGq0tc88FgEu1btsrQkRHXDVmP14=;
 b=eKgH3wotEGwXhiBN25Lj8Q6bjFHNCO/eSTaF6S2AQorq8KaZLDBcQJ7RkSDezRm7F4nedpo4ACqxZTKiStiCZj8o7Z/vV5mcOa4S3Kou+Y5N7xTS1IvWz1y+XT9NID2yoyYCIl7q2TytBVNM6bkBDBOGs6syrn6p4a4dfyD71Ok=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 21:53:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 21:53:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Topic: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
Thread-Index: AQHZacp2wdCHl9MJskyADf2q/cMSEa8wCLYAgAAObICAAAHYgIAAAYOA
Date:   Mon, 17 Apr 2023 21:53:35 +0000
Message-ID: <B7A330E4-EF62-45B8-BFD4-F1465A934BFD@oracle.com>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
 <ed95d6e3da7b2a27a27837f19ca39980037eb28d.camel@hammerspace.com>
 <C7FE1DB9-576A-4463-81BF-E7B1EC266E4F@oracle.com>
 <8723e01c577e257c399e8d3b6e20bca6320964c3.camel@hammerspace.com>
In-Reply-To: <8723e01c577e257c399e8d3b6e20bca6320964c3.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ1PR10MB5978:EE_
x-ms-office365-filtering-correlation-id: 4a08e03f-fb65-47fa-21a4-08db3f8e31ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBFyxEQevEv1CyKbL5jK3Kz0sJN7KFveGL2dBCyyapp176pPEa7A/ktkU9aeGQ+jExmxhrMry2vOgwNTr4kIplVl+G44Py7e2Sleoi/Vb87vYanP/m3Z+gjjimZH7Wj4fe4GjumTZYEoiHK1hCCoR9PR9+TdALk495GaLCgFVk8aAmipp7uA8ykCX2coLkipqtZbW+Z7DzoKO/CWlPzQOHbi0ZyzCPSTWH9sFhdumEEogx1M7TmTzubr6jlwXZi6xSX9XFfnO5my2ZL3pneL9PBXvQOGBezd8VRZNst695qqdJh194JZqmABVnfD4xqmN9gEAtlMvezv/6h2JKgsSp7ff6TzIYGiUBvVe+MqhEkre7vODVcOIRZThLAV6t878vFBj8Fc00o6BNEur/35Ce661KFkD2pw9Y6yA/qJuliHs3a5XKymFUSvq3mscrVM3tS9vwHUW2MFSHuEDm4ECy/5mOaGZJuntV7CTwkCoBDJb0umg2YnRK8eOpspOEn5gMdLpOdTBBInFEPy4bFFhEFc6YXU7C1zmIbWLn9iT0yrre4KybTEyH9QQWMQUcmTDR4qP2lGjgLlPLJln7VmTNYXFMY30v+qAjzPWSnDwMJKizyPIgBfy4o+pJ2XdZY7M/c70w76QADib5yDCREJlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(5660300002)(2616005)(83380400001)(122000001)(86362001)(186003)(26005)(6512007)(53546011)(6506007)(38100700002)(38070700005)(8936002)(8676002)(54906003)(478600001)(33656002)(71200400001)(6486002)(41300700001)(316002)(91956017)(76116006)(36756003)(4326008)(66556008)(64756008)(66476007)(66946007)(66446008)(6916009)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?++O3fHIHTzYkQA3hmKJM33b1DImSXxlewoN6o67bzu39x9hd8up5bBcDsgb0?=
 =?us-ascii?Q?SimTCFwriowoSrKooeRxmJUjfTc6gGSElb3aFRwxY9m8Rh7XHo7CfjXhesp8?=
 =?us-ascii?Q?OGBW9xPJk/0A4+weM8arnf+EqXoVZNVXu6+h0YUuLI+YeewpmbnYEqQC9/yC?=
 =?us-ascii?Q?1hWroDav+2M5CyJBsgNufkztoNDSuQYSzVThaa5b3WcXs6L2tbHD9ZXT9IkE?=
 =?us-ascii?Q?+vCGDP+jd1EQyt8BovLbuQ1CUt/DEu5D9xSjgIxAPEt5XOcHckmYVbiaPUks?=
 =?us-ascii?Q?iFoCupFPIyWOr/dV1OgLTs6jDfDzv6oKm6U4O76KU7LJ9sOhc0rFlZRYFMhi?=
 =?us-ascii?Q?eR4jHtUObsnIUd7jxwoy4WKjBAw7wrZAdupc116C3Jw63Dit6/RL42LUKYW3?=
 =?us-ascii?Q?3ZN3+z0vLWGBJ/YSgTiAwy63pziX9m6gq4E4xJ07UesPIcP6BMwUIPrcX3k/?=
 =?us-ascii?Q?9NeKeFLsfpnY5YWGofHM/SHEIMDb03U0ZhbPWridLmRfgF1KRkJvZ+Vx4WwJ?=
 =?us-ascii?Q?QTLS8sKHz/+ROodDKnX3guVzZnz6O7XFLApQkjzMQrbiYqq1pC0JPgxqllpb?=
 =?us-ascii?Q?fCrNkCtWHr51r7L5xc2p3maq1wcFi3afTHBca85dZzC3Gs59HeZb0f8Dz/e4?=
 =?us-ascii?Q?wRdAMWRUrvYtXCsqd8SpTwP/7ybK35PWpy2YG5GxVG/HtHed6i6aUpBrmz29?=
 =?us-ascii?Q?LpkxCTKbDylLnG5DHzdlB9kVrpglPbspVujaut2om4stGybK8yJuHoCGunks?=
 =?us-ascii?Q?iFZsRvgkMQ1Vjfmmb7gDmjunYQAcfvv51DgZcN6Iai8aPBLEtuWEKaHgyKMM?=
 =?us-ascii?Q?9MKt71Hrto0PbGhN5aVKLLVg6LU0/F3oXDUV3ym71xDV29/kGqF/s5fEtvSO?=
 =?us-ascii?Q?29K4VxzlqnOzawWrgTMSYf+dJAWpmnDzXlaVcdN/oaezHVnrFQDMf8U2Q4V6?=
 =?us-ascii?Q?hCF7+aO1KQWilMLe7z6BWfh8LEQB1b5Nwn6KwcxvLyfMd8QY4mTfD0yT47Az?=
 =?us-ascii?Q?zLAdmTT2BoYiT/ZZW0b3X48WKtyIBn6v5jz8eO4yKjkss1rROih8V9TtQlqf?=
 =?us-ascii?Q?VUrhYSokD1lRfeIEG6lIh0Xv1kw1g0VKN2zC7blP1sidUaivEOZzF9x9ujaV?=
 =?us-ascii?Q?KGi/wiQEZTOzVQdwjvm4ced+aQzNw7Dqi423v2FAFlOFL71mnvtxwQEgXMU6?=
 =?us-ascii?Q?+qHlYr6aRYk/zdURNGM+TEfQz1SZSmq/x8/kGx8g+E92YQ+cgK6swfaaR23C?=
 =?us-ascii?Q?4FNhL6WFbV5IHMgoPigUSppsptN/t/tHiVLgD6+1FH0eXaoaF2q66kBhWOWg?=
 =?us-ascii?Q?veVFQdKKemAY6wAb8qihw87uSuBoHkIP3wgZoIEjkO/QLZ1Z3ywKB80fXrAE?=
 =?us-ascii?Q?Bn90MkVj04DQdIuJn1YeDoWICo20lThQX839w3sIULuFnwtYqqLvtLZA79ap?=
 =?us-ascii?Q?uESLCsZTH16fb7BSGHBceDblAWygU1G8cFxM7f4Vtcv2m13mJ+Hzz6Y+5Qe9?=
 =?us-ascii?Q?zK+Wvbr+meTnax4g7DMbqvrh3X9CacURloei9Gm+xQ0iMKJLgn+ic7Hu0Tkd?=
 =?us-ascii?Q?4JbvrK5mBF/zB+bVjsQoqVxiqOczxehmgPDfTrao9IxubtcXUut634ouCn5k?=
 =?us-ascii?Q?ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F69465321A795D48BDF344688203765C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MhR+MGAI6+WzzavT8RiahFttSdi2hz1wtrbv6ua5hC8v33/IlTElbjoZ/SwcenhSlnxgzVIbEJdIIZWTXXiyTCUv4tKqvKti+ZnDtBBzUWz/IKF6JKr8zrUfE81ugqxitQwJwyvSuwVHd6bQUVgUCASqMIMxdjdR+JHgJiZnA6KYXFzJoAgbRixgKMBVZrjCcyadxgHrNXD3kOJehSynMmeq8i47/uGhDmdLpOGrO9pPqy1LCNp3NL3fXI/nu317tLm0+LYLsowmq+J7gOeEhmJWW7l7NrlRFwFLtl1VB3xsARmsP53u4hYXHgNGrHEAxMuyKxpd5ymXK2SI5R1C1N6LKR0nkbgV2zFgn1sMHwhh7DWeD9kkfsIQvlNEGXI1NV80Nrvv2BqIo8Kxk8k73VUdRAW7pe2yVGjs1NFXwF++2o8MGEl07xQ+DLw8dt4cmMsi4dvQ3WJ6O7wzs5BQSlCE62lIz+ZajtMjkdLayU7s41MGxkHdvjGDdKH8EcsM8PUrC0muzOLwGuC3FqWExShiCitvR+378b+UnKIap5/hG1eEF4aAfb+ShPKjOJ6bIJMiefibe4c/i0LddkWnDXOYam56SOUnrXIIKGx266x8A1ZbBBItNuL2LlRnPk1dwOUzW6MXbhgkBNnBS5/woDl+BD2RVD4z8cU4IZS++xDaQjQjgPwLPxSIhGR2I4BNDd4vFqlW6M808NotPGwf3A8N3qq3jLp+1xLJoqVu7lTIR2f35EzB2qE0TcnwrAVihGFN5dbdfu6rbNJH2NxElts2Fd2ds6x0CHxVTu9htCDlE58+qTvMhFUT5lHW6RjHz9RggYdIyNzXTGFbvmfP4A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a08e03f-fb65-47fa-21a4-08db3f8e31ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 21:53:35.9647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OwDBrCgGSkLK5MCfF09rwMWCbJHK1pT2IACMp5WIhsn6ZJIbqvZVv7Uh8u/SL8ukbvIhJiR9AXj1RfJN1D+fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170193
X-Proofpoint-ORIG-GUID: BDmfTdLsJS2OkJjv5EmDRWkDmQV0jT3a
X-Proofpoint-GUID: BDmfTdLsJS2OkJjv5EmDRWkDmQV0jT3a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 17, 2023, at 5:48 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2023-04-17 at 21:41 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Apr 17, 2023, at 4:49 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Fri, 2023-04-07 at 20:30 -0700, Dai Ngo wrote:
>>>> Currently call_bind_status places a hard limit of 9 seconds for
>>>> retries
>>>> on EACCES error. This limit was done to prevent the RPC request
>>>> from
>>>> being retried forever if the remote server has problem and never
>>>> comes
>>>> up
>>>>=20
>>>> However this 9 seconds timeout is too short, comparing to other
>>>> RPC
>>>> timeouts which are generally in minutes. This causes intermittent
>>>> failure
>>>> with EIO on the client side when there are lots of NLM activity
>>>> and
>>>> the
>>>> NFS server is restarted.
>>>>=20
>>>> Instead of removing the max timeout for retry and relying on the
>>>> RPC
>>>> timeout mechanism to handle the retry, which can lead to the RPC
>>>> being
>>>> retried forever if the remote NLM service fails to come up. This
>>>> patch
>>>> simply increases the max timeout of call_bind_status from 9 to 90
>>>> seconds
>>>> which should allow enough time for NLM to register after a
>>>> restart,
>>>> and
>>>> not retrying forever if there is real problem with the remote
>>>> system.
>>>>=20
>>>> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock
>>>> requests")
>>>> Reported-by: Helen Chao <helen.chao@oracle.com>
>>>> Tested-by: Helen Chao <helen.chao@oracle.com>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>  include/linux/sunrpc/clnt.h  | 3 +++
>>>>  include/linux/sunrpc/sched.h | 4 ++--
>>>>  net/sunrpc/clnt.c            | 2 +-
>>>>  net/sunrpc/sched.c           | 3 ++-
>>>>  4 files changed, 8 insertions(+), 4 deletions(-)
>>>>=20
>>>> diff --git a/include/linux/sunrpc/clnt.h
>>>> b/include/linux/sunrpc/clnt.h
>>>> index 770ef2cb5775..81afc5ea2665 100644
>>>> --- a/include/linux/sunrpc/clnt.h
>>>> +++ b/include/linux/sunrpc/clnt.h
>>>> @@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
>>>>  #define RPC_CLNT_CREATE_REUSEPORT      (1UL << 11)
>>>>  #define RPC_CLNT_CREATE_CONNECTED      (1UL << 12)
>>>> =20
>>>> +#define        RPC_CLNT_REBIND_DELAY           3
>>>> +#define        RPC_CLNT_REBIND_MAX_TIMEOUT     90
>>>> +
>>>>  struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>>>>  struct rpc_clnt        *rpc_bind_new_program(struct rpc_clnt *,
>>>>                                 const struct rpc_program *, u32);
>>>> diff --git a/include/linux/sunrpc/sched.h
>>>> b/include/linux/sunrpc/sched.h
>>>> index b8ca3ecaf8d7..e9dc142f10bb 100644
>>>> --- a/include/linux/sunrpc/sched.h
>>>> +++ b/include/linux/sunrpc/sched.h
>>>> @@ -90,8 +90,8 @@ struct rpc_task {
>>>>  #endif
>>>>         unsigned char           tk_priority : 2,/* Task priority
>>>> */
>>>>                                 tk_garb_retry : 2,
>>>> -                               tk_cred_retry : 2,
>>>> -                               tk_rebind_retry : 2;
>>>> +                               tk_cred_retry : 2;
>>>> +       unsigned char           tk_rebind_retry;
>>>>  };
>>>> =20
>>>>  typedef void                   (*rpc_action)(struct rpc_task *);
>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>> index fd7e1c630493..222578af6b01 100644
>>>> --- a/net/sunrpc/clnt.c
>>>> +++ b/net/sunrpc/clnt.c
>>>> @@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task *task)
>>>>                 if (task->tk_rebind_retry =3D=3D 0)
>>>>                         break;
>>>>                 task->tk_rebind_retry--;
>>>> -               rpc_delay(task, 3*HZ);
>>>> +               rpc_delay(task, RPC_CLNT_REBIND_DELAY * HZ);
>>>>                 goto retry_timeout;
>>>>         case -ENOBUFS:
>>>>                 rpc_delay(task, HZ >> 2);
>>>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>>>> index be587a308e05..5c18a35752aa 100644
>>>> --- a/net/sunrpc/sched.c
>>>> +++ b/net/sunrpc/sched.c
>>>> @@ -817,7 +817,8 @@ rpc_init_task_statistics(struct rpc_task
>>>> *task)
>>>>         /* Initialize retry counters */
>>>>         task->tk_garb_retry =3D 2;
>>>>         task->tk_cred_retry =3D 2;
>>>> -       task->tk_rebind_retry =3D 2;
>>>> +       task->tk_rebind_retry =3D RPC_CLNT_REBIND_MAX_TIMEOUT /
>>>> +                                       RPC_CLNT_REBIND_DELAY;
>>>=20
>>> Why not just implement an exponential back off? If the server is
>>> slow
>>> to come up, then pounding the rpcbind service every 3 seconds isn't
>>> going to help.
>>=20
>> Exponential backoff has the disadvantage that once we've gotten
>> to the longer retry times, it's easy for a client to wait quite
>> some time before it notices the rebind service is available.
>>=20
>> But I have to wonder if retrying every 3 seconds is useful if
>> the request is going over TCP.
>>=20
>=20
> The problem isn't reliability: this is handling a case where we _are_
> getting a reply from the server, just not one we wanted. EACCES here
> means that the rpcbind server didn't return a valid entry for the
> service we requested, presumably because the service hasn't been
> registered yet.
>=20
> So yes, an exponential back off is appropriate here.

OK, rpcbind is responding, but the registered service is not
ready yet.

But you've missed my point: exponential backoff is not desirable
if we want clients to recover quickly from a service restart.

If we keep the longest retry time short enough to keep recovery
responsive, it won't be all that much longer than 3 seconds.
Say, it might be 10 seconds, or 15 seconds. I don't see any
value in complicating the client's logic for that. Just make
RPC_CLNT_REBIND_DELAY longer.


--
Chuck Lever



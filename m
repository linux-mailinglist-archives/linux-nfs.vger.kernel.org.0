Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056F857FFB0
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiGYNRL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiGYNRK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:17:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9155FDF5
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:17:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P9Y1QG031251;
        Mon, 25 Jul 2022 13:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TF/X3/KEGqlKLkVxoK8D1HNQ3ytyyZ5pe+kPxpG20Tk=;
 b=lv5tULmiaOgNouKCA5eN+If6V0kO51CrpUtfmLSzoFOJJLmmDjUSCjs8yxOaCOZMeUH3
 RhAaTeVVuiYINyhJ/mQGUdnwM+9VJvW44OfwTEJeph5K91j2LK3i5jeO9I02+uuVwIps
 pdnBThjaTSHdjZTcERioSQanFM1cSqxl5HpOOts9kegH+giiemkl1KwfaOay8WcY3S5V
 cfX7vponuQOgCaDek47sqR3l2TvB7JDDj0k5jFxFnVDloVLkPK8wiEqh3sTPpKVIWFtP
 F+JlA9qMuvom+T0dLcLRIrBwuZ0ISsx5w98nyPsRBFvw9hEVng75w+psM1gH6X6hT/U3 Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9anu784-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 13:17:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26PCQcPo023058;
        Mon, 25 Jul 2022 13:17:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5ytff57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 13:17:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmLrBdECmz0o2BtQhuBkG2MCGfeAbawYuQtBOl9V1RoHH0tzZrVLECOwQyjqMGOmetp9u57c6GSaqRpl6lMC1M8A1uEL+YUS9Orr70eGjVr3ey2o5mIDKDObh93BrIMmfSCwjRiPzE5l4TdUv5Zc52zFNwh1XtCfbK0cCxHslONrzDho1NK0+RToxPO3zUP1L6ZLb8QWa88FqpVZ5z2/uCb52HCzqG46dyjDSW8ZnHoMmcRIyHwz+twe/CbWRUUaLVV8V2q4PdqQ6GWEkdXakNKlOL7VoDM9fVTSQYnT8TlxNhgjwOMn3IfTW6vRlQ0vlPxsXQ01V2Lc0cyIpkJzwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TF/X3/KEGqlKLkVxoK8D1HNQ3ytyyZ5pe+kPxpG20Tk=;
 b=QhnXYmXI8xeLknQZfWf5XhS8OXHnA2fmNHqvPUX8OGhVVa1oePd0siNKoVDZ1G6zZTX5b/qyWWGp0rK2vMh1oe4oPf1b6Rj1+Ikug7OWQPy+54e071DzV4czhbBX3eVlgvsIFsppXlzx64iUWjpKRaCFAeY1hIKeZpwpeJz56wXBjQQJshzvUeqHYUsAaNAY/7YzhtzD55/VfulrPCWTSvKFkWGah9FON8nWqlsbzgtoouXknVYX1tGBlK0UZm4aDK+dxX4i2gn5JoFhKZm0DPmaQuLFydskzpudiMAGTLL5GMFlM3jQnJxqMqboTNlXQQh1y7ICjw4FBQaF40zlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TF/X3/KEGqlKLkVxoK8D1HNQ3ytyyZ5pe+kPxpG20Tk=;
 b=ZBcMepI27JIV+p8KqlTg46xpF5SQNB/aANxz3a5TWuKFfU12SnogBa6GVir7joHdtgIyxTIEuA5w3DUrY9Yn9XkUhYdIS09dJZWdlCLszwIIckyG1sJGiwPihQ6kcmXVkjCwFx9Ly1aNsoS4Dr8LmwKfYaRQNcA79iRxDHabnOw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5822.namprd10.prod.outlook.com (2603:10b6:806:231::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 13:17:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 13:17:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH 2/4] SUNRPC: Widen rpc_task::tk_flags
Thread-Topic: [PATCH 2/4] SUNRPC: Widen rpc_task::tk_flags
Thread-Index: AQHYnfAYpiEwiP5Q3kuMeAXmLUJIKa2KrAOAgAAAjACAAbgDAIACsTUA
Date:   Mon, 25 Jul 2022 13:17:03 +0000
Message-ID: <09580952-BAB1-4437-8903-F0DD2FE5C1C7@oracle.com>
References: <165851065336.361126.17865870911497306083.stgit@morisot.1015granger.net>
 <165851073589.361126.4062184829827389945.stgit@morisot.1015granger.net>
 <55155a8f566599ecf802103a8d7d3aa4ea3e421a.camel@hammerspace.com>
 <F3BA47F3-DE56-45DA-8E4A-4E8A65D5541A@oracle.com>
 <9bbefaf99fa4857a7718bea72127b5dd64e72898.camel@hammerspace.com>
In-Reply-To: <9bbefaf99fa4857a7718bea72127b5dd64e72898.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cccfab4-9004-44d6-2e97-08da6e3ff734
x-ms-traffictypediagnostic: SA1PR10MB5822:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +i0jCmGyeSZ7g9O9ar0o8oev5q+19eYjwgvbBXhkf2hMErtfMnAuXPMZL+U0cU2Y+AENnCFB8t7cvnUtoAR27O5YXd5tSBUGqw2xv8T9Imuo2CW5lojSM5/p5KOvJKqxyI06cRb+H2zZjXLbxviQ3Nl0SLXCfR9JmuUvXUQBkacs4Qxx+VRExiP+Aku2IU/8cwHdRfwL+HNUcE7m5QxB6PkaXLeWP2F0YPDMufIrm+d852FVOMQ5GyE0zpO11ngwMeL9H0RrMb7lE9We0gJ72SA9S7yKYbToTnmL+HZnmrhLYrZ2F8zmHBxlavd17SjLHPXtKHzbDQzkNWYaX8Ohqc6NLmYPH3JwlR9Dcoms4zKFBx5lgTNAQ+CKN96z5UYpdM4sGXzpaipTHs0T2qy+s541FKLRa+ARKUbqTzHRxIYPjk09zAMK6Xbr0uDU0/bI1QVllhvX6zrQeVbMaIZvSZ3kz0v1Ir73YVIM6sIBwGHB8oZax7oZb+tfgimpPrSo4aqkOXP9TLCZc94bTdt4Jqt8DGvhvc9S+SajISamIy+PgDnU/UrgpDnW/HSWBluTOjnyoMtR7t+rVqa5q139KZH8MKWm9IvFFOZ5MX7D+NSQALpRFl/y3WBc9oblWUCwahf+KKwsIAqMEumRwwmACqUxpNoMmOgV4OouRQ7I2R6ztKWPHuGs/lAW5X50ZH62vNVJlWNfZyhzC2CdItVCNtS7wi87YO/9S2iayQp+ZONlAIy3BHzMLgNfTIqtzWcpPaqwF3Pc1/Z9iH6UGZCMiZL/qIiOiIbxKM43NQsOigN63/JqApNgExhQJOYsbqgM7yx01dXj0eSU3BWlX4kuXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(366004)(136003)(396003)(6512007)(2616005)(53546011)(6506007)(8676002)(71200400001)(6486002)(478600001)(316002)(54906003)(41300700001)(186003)(8936002)(5660300002)(6916009)(66946007)(64756008)(66446008)(66556008)(66476007)(76116006)(4326008)(91956017)(83380400001)(2906002)(38100700002)(122000001)(38070700005)(33656002)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9h+Dk9tuKTxOkgKb0ioBZkckQeGXMezQtuxc8VFrZWqlaHK8O2VwIdlvtboL?=
 =?us-ascii?Q?DweY/DmFdgLMF0ikQIEfrvtjNrdFoHKCZp64v1oM6erzPGmRmW6bF8LiEHpn?=
 =?us-ascii?Q?oFVjpRF+UnYgLnIObGKuAwcsQH+SyXKfud89+jlOewEf7UOZU/E/T7y/PFWC?=
 =?us-ascii?Q?Cd+wucHRt06+9W7Lt82w/63rNXVdHbyejAUE3lcJguJmDaEV1TZGNivy/cf0?=
 =?us-ascii?Q?J4lI0HLwQ9Y5Q94gJI767MwPc6PgCfEWkhrhNKpfi+nmHdJgQrBdbxlw+B4b?=
 =?us-ascii?Q?CUrxjrnw9QjR1VYMpFI0GlIy2+hUrqhSij8jGOeI8Rk2y355Q069/L3KpYA5?=
 =?us-ascii?Q?C6dZfegisVV0uvnIV211JSjSZUvYrcK+HGerAQX5Cf5/MwKJzZNbU4gGxyqj?=
 =?us-ascii?Q?Fotw4+pN+C3CN66OHhElWyEGQVH7JSRugbjt7uyddxTKUTc6PQKBAwukkbk5?=
 =?us-ascii?Q?c6lvejz6Oikd7r4unpJBUHNULaHeWciJNUPBA4zMFDaLhxPY2Pp0+txGBp8S?=
 =?us-ascii?Q?HSeIOuyU1mFeZ+5Y6cVkQ5ixo+sAThyKNZ1hOpuUyei5jafR2wnkshmFNNwZ?=
 =?us-ascii?Q?OY3Ll52Bs/L+Ll7kDl9TiyysRHbQNpQcdU4iii5Rw7gAomYI3hqYO9Un+vr5?=
 =?us-ascii?Q?6ci52/Hh04Qt9H2Hho5JNdCFp7yWPIUisXBbooTWxKQoGGhEPj7BnxtQBC2T?=
 =?us-ascii?Q?0+ODk5AtgPtFC0lKpUAMH5i5UYn/vL+4qaa5Q6eb5LTbYtQHwOmvhe0OZ/TG?=
 =?us-ascii?Q?EJY1wPWyXJfNLmhGY42qHh8a+3ePg0xtMdEKHxvUUkrTQJ7gep6m+lLVNBUN?=
 =?us-ascii?Q?wtGGJfylZ1b5ta8FSwiGyUWURdQg8Gj274wIof/puIzFy+BqLUFbpyG2+dlV?=
 =?us-ascii?Q?Zc6SujCFXOPmeznUKqOSGgr6nwbclXseXhitFegavOrDfd4Z4uZjp33cDtof?=
 =?us-ascii?Q?aoFHsyRHlJn2fY5K2Q27pRVBSa/emwAPrAyGrsipc3/hUZ532/JRsKRXmBnQ?=
 =?us-ascii?Q?iJ109dEsFqUHzq9o1m+2plvvjgMtPic2Q6uHXltlqyQWhK5PJuRG2EL7Rjra?=
 =?us-ascii?Q?C0pnoRYBygZxEKSl1SMwvzJXRQBhd+oCw1jiNNAcOytZGDOGa/ZdM4KRQonC?=
 =?us-ascii?Q?rNpv455nCXORz13fT7UazJ/bFj7XTWYxNCn0zXNJ3rAWexr+o4tqEVcOuPep?=
 =?us-ascii?Q?3Emta0I4zuVxZEmiz5c5b1MWEgeBL6ckPmxwWRCU4SlRn2f9QIm+aARJH/c5?=
 =?us-ascii?Q?qTpn5MwJKspT/ZUyUOLmn3/OP3b4JszLrigym8Wdqz6uYIr6+sKxOQb2k9xn?=
 =?us-ascii?Q?8ZOxatcjbKiDHYbEVHA/b9/XpALysQKGlERIy3zS/1TtQYDfcltv16mJMrZi?=
 =?us-ascii?Q?BZdlIKwZFTjquBoHlYWHo11J72n6+8zmMK1qfmwlFzcgYd4wKnS3YwCrQrr6?=
 =?us-ascii?Q?wnObzbnsPP0xUa0YKq024Hrxz0148cthrlIbnPT2XIcDZPoomrwV9MhhZdVt?=
 =?us-ascii?Q?NxI5XqL0aCZp3Lglp7XRudPBNwaEZgNp3iOVyH8hP/AalgpzHBAlWXb4y/Fy?=
 =?us-ascii?Q?K5uJ7KBp9LGSVNO6oD/NiU3V71+Obv8Xyp+ZSRHrQkdHuey/Sm3w34scsd5c?=
 =?us-ascii?Q?Ro6AdJGKXJlybYWZJxr2dBt0JVVrKI+pfzLv4MBqpNZYEPa7wNuAAR4W8X+U?=
 =?us-ascii?Q?Zz+Ybw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE2E62C739C79E43A9BD510CBC7B4811@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cccfab4-9004-44d6-2e97-08da6e3ff734
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 13:17:03.5264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTpw6cLgTyZGUaaHA5SF2ZgHGoBgOtVSZ+X4Q2xFOjkQUdLUItsHTrCcH7ELABxuouFOrZFLnK5zqL5s4Lj//Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_09,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=794
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250056
X-Proofpoint-ORIG-GUID: -Jb8-SCM2bPiDwTmWtrpoTHpkAfh7sUK
X-Proofpoint-GUID: -Jb8-SCM2bPiDwTmWtrpoTHpkAfh7sUK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 23, 2022, at 4:10 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Fri, 2022-07-22 at 17:55 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jul 22, 2022, at 1:53 PM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Fri, 2022-07-22 at 13:25 -0400, Chuck Lever wrote:
>>>> There is just one unused bit left in rpc_task::tk_flags, and I
>>>> will
>>>> need two in subsequent patches. Double the width of the field to
>>>> accommodate more flag bits.
>>>=20
>>> The values 0x8 and 0x40 are both free, so I'm not seeing why this
>>> patch
>>> is needed at this time.
>>=20
>> It's not needed now, but as recently as last year, there were no free
>> bits (and I needed them for RPC-with-TLS support at that time). We
>> will
>> have to widen this field sooner or later.
>>=20
>> I don't have a problem dropping this one if you'd rather wait.
>>=20
>=20
> I dropped it after applying the other v2 patches.

Thanks for applying the others; I'll drop this one from
my private tree.


> As I said, I don't
> see a need for this expansion yet, and if we do at some point run out
> of bits, I can see other flags we can drop (RPC_TASK_ROOTCREDS and
> RPC_TASK_NULLCREDS being obvious targets) before we need to consider
> actually expanding the size of this field.

Agreed, expanding the flags field is no longer necessary for
RPC-with-TLS, as I've converted it to use the layered connect
mechanism you suggested. The flag it waits on now is
XPRT_CONNECTED.


> In fact, by not expanding it, we can trivially shrink the size of
> struct rpc_task by 8 bytes on x86_64 simply by moving the field
> tk_rpc_status to eliminate the current 4 byte hole. I've added a patch
> to do just that.

--
Chuck Lever




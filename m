Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9333244DD
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 21:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhBXUFo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 15:05:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36420 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbhBXUE7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 15:04:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OK40FU180638;
        Wed, 24 Feb 2021 20:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZXPlY1KRgukrCtQbPrO7jCkbqgeXU/v81HbQaGHqG1o=;
 b=w6rjv7I79uRLPkZCIV9eW5pZispfRvMyVOEDrQ8nsmPYwkZzoL7pEcCLLVU3uhkYI2G2
 ce8h1iRVwuxc6K800s9bC15l+KkjCztOYGJnPTeOMsfQ5zcdP708wFXE76vver1ijGC2
 NgmNLIuGpI4jcVjwEok4sQ7dyoa8hCWZV9tCsIbpJ8ov1tbljruKpUOk+BODYaqcKtUN
 pA+oP7BOyvi25lDwOzRnXEznZF7pnWSdAKNQC0pm73HhdQ7Jg8nMMU/D6Zf/jnx6CNXy
 2jna4CRn0SX9IMjDGV6kOyJgDhgDyfrUI/GSu5tn1DjwocypTjScUoFMgmQTF9cUY3dY jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36ttcmc7ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 20:04:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OJsZOJ048722;
        Wed, 24 Feb 2021 20:03:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3030.oracle.com with ESMTP id 36v9m6d1r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 20:03:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIiOysfNNU8IIlfc0YOIRwNx37JId9dUnwD6L2AXJqdv6xXbteXeuCDo8yCzMZBzvxe+1qYEQSIODm4U0i4ph1wVLCsofJbeLHcILDga5JidMJ6wEF4pPrv9Z33Q8EOdQtCPSAoydcQtJoP2zvo5ykWBuExrNlZYnw5pJDXCdxo8DbppVSRoiIN9oglb6EzaTCq1karDiduY4dlSpnK4M32VF+wyZsIh3jCkFsoN2ErG4FK8GP1tkQlEZK4B+ZXmnAL7+NGbGFQvjRB2f6Px6QSmoQ4grNR9rCmQMXXhHTA+N+3OO5Tf+kz92x+zU1k5GNrLMQrQ5+UB5onqsXWzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXPlY1KRgukrCtQbPrO7jCkbqgeXU/v81HbQaGHqG1o=;
 b=dxeplEMcYVCpFpXUQhyFPbaASEHEXfg8rRDXziPNcg1I7LOCrgJ1P+yXUeKf0HKOnlEkDb8tgLpYNdoBGHB3qgG+ybZjdci/pb9ATz88XdXmlrICMbdHgtHZxchLbj32fA3ileqtb9uCXTBWzGQ3v7DVXorlHtdvfylKuHdRryOA6pWIJ+0IhEL20aG0T8u/XhIxIZdkoTmbrZ27A1orMgPh6w+3yk130vploMfyIEHfTx8vThaKvCzxi5/+tu5l2T2am/OAPPv2Itnrs5mYwQJE2L+nKIdJHLHOc1mCPykij8A8bgFV2HdKlV1rpeRejAwshZH+FP22LNSEKFP5gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXPlY1KRgukrCtQbPrO7jCkbqgeXU/v81HbQaGHqG1o=;
 b=dk76bmNm5mLauMvK17kVdrGNmSp7SmVsqeHN8w3ACN/mdvBCVbN2bJkgJyfYUj0ly4YDYK8jV+6OGE58IGc2cXda98XNyRHjwBmzhrvYE8uqz+2z4UeO2sdKoWKNycbtiGjpGq7JokDbrcvMAiAMv0Y0uaqSWV6g8jxO39Ffias=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2439.namprd10.prod.outlook.com (2603:10b6:a02:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 20:03:54 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 20:03:54 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH] svcrdma: disable timeouts on rdma backchannel
Thread-Topic: [PATCH] svcrdma: disable timeouts on rdma backchannel
Thread-Index: AQHXCXOTv6ms0S5nPkS/+o1NfiK5PqpnXOQAgABgLICAAABigA==
Date:   Wed, 24 Feb 2021 20:03:54 +0000
Message-ID: <D208366F-8FB7-48C9-A380-5518AA845B6C@oracle.com>
References: <C99EA5DE-814A-418B-9685-D400F4E7B964@oracle.com>
 <20210222233619.21568-1-timo@rothenpieler.org>
 <E650E8DD-9F65-4029-8F3B-AA854AF575A1@oracle.com>
 <20210224200231.GD11591@fieldses.org>
In-Reply-To: <20210224200231.GD11591@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d307bcbc-1064-4b78-4cfa-08d8d8ff503e
x-ms-traffictypediagnostic: BYAPR10MB2439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB2439ABD60856EFFB382B1E63939F9@BYAPR10MB2439.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cio+U35o5TRheyU1zZ1d2sugnCSr90yexSo9IWbtKhCdIMZ/xdXDBYnK2A6K0m9DIJxQALvZHmTc8biwzDFa4Onkt9DhuFTbR5uxccu89GZ9pkde0brKOe3zA45Hf7+2JZZmo/QmdOWZ4DKFXs2hM0w7f4/s3g+vFnPFOl3pJlIahWZubw26RMOdLJ4m9dEi8Z9LRFQ1m0Fgrt/ZSFtpuTpXbi0qjMWBXZx+JWcdjp1Hkb+UP/HDavlPdmphGTtreZWcDmjlzJRo1FInehextp5wVBC/nNiHiCFdEnNSoYi27XUd5QIY+CHaPUxNgtfxR3NsCezVwvZqoDnQmOrM4D6pqXwCvGMRhGtmqyphhqumeLWtVr0/DPebNmx0NorUN1dmiWFmL7+iW9NCcc1y1bP3CFAqaXn8f81xu6VP3yC5PpfA36LgGh1FWtE5VLkIcU9j2cQY1rSC/AHdgqINeNHGsa7mEZ2o6npMyVPdhGrTmUdKnsH1rinunbEHMiQ5ZDf4haYTjxEfCa89NDHZeUPdFp6OLfj6fsQ3i5YtKrklZIAUuHiZJU10AUr2g1H+Y8KyIzTJFh874OTOa/n1Dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(366004)(346002)(8676002)(8936002)(478600001)(33656002)(44832011)(2616005)(2906002)(316002)(107886003)(5660300002)(6916009)(83380400001)(4326008)(66946007)(71200400001)(186003)(76116006)(91956017)(64756008)(66446008)(53546011)(66556008)(6506007)(66476007)(54906003)(36756003)(6512007)(86362001)(6486002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cMWUwpLGtYlAyNga+jih2itTskWwFChMVSMnxAswSHhMxZ+hLxgoQncglrX5?=
 =?us-ascii?Q?DgIFQzALvQ9CImzk/pCrIfneOZ5tF9BLEVD6Lm8nhTePGYVlC8s+RB576BVQ?=
 =?us-ascii?Q?9iZEy8YiPdaH28BEjXYbB6jW2g57Db4Lygg2anIhJOYygtAWpj2O6YUZZHSO?=
 =?us-ascii?Q?2/BG1I39W/O4Yc/wbdVlLN2sCgsuR0nO9N64vRO/kRAZk0J6iPua0WZCNlrv?=
 =?us-ascii?Q?OOc5qIHZaQw9GVSQI3nhhmfOSC7EaLaq+iZPTmorJimtA3aUNmX8huHZ2qi9?=
 =?us-ascii?Q?vcxuQ6roSsVVF3VT6oWH/AjFMs5opHnXQRt+Dwr/CVjRaXP7adRIy3dRnO6w?=
 =?us-ascii?Q?Yul2UfDeu4hMuYjZiy89hMk//LaZBTOSR6XLuakl14CrO4CACZa9SBJM1YCx?=
 =?us-ascii?Q?1ObENNc0o/ryCoGkkYQVw++utTCcaEMbbSdVATEwHZdWhfROtRH3/8e3Sy7e?=
 =?us-ascii?Q?wB7H9QnIK78FAyPAEE5ZkiGJTW7KzidVAvvWFmUv/sOMvqHzgyzkoXo8k0ew?=
 =?us-ascii?Q?zFXG+ufhJjYxVbJsaBaH9PcnuPWsmEL0S0k5yQt8cGDZ9nt1XXzr6EtPpy5x?=
 =?us-ascii?Q?1nLIv8ipziRyuQQGD7HH90frIp6g9PlgGO2kjzWxxdcrhQSj5eN/hAlNEni7?=
 =?us-ascii?Q?ucthXXZ35jeXfQX7rrWW6BTsDSxj7v8u6pRmGdhtrqV9qCnzhFtXrT3n53QO?=
 =?us-ascii?Q?2iut+cs2YfEJEjAk2WGzA7TI/4+dZ2Hi8dpvp42zlaujuFNoUu9NLMNRxrGp?=
 =?us-ascii?Q?nusXtoTN2l0pW1oxyt0IrcWUGT+o64y94+CrOlOkBevwWiG8HwpffNPN/RyN?=
 =?us-ascii?Q?DDU2GExNKe/GSmPf51I+9IBvNGYUlrIbrZLKnEBeliVej+YYBWw/SAKCNFXu?=
 =?us-ascii?Q?GeFIAJpeNoUzpl56M3lvwGHMaUY/oXOBUtL4Dxx0N7EviSrWGfyPTX/p6Q9x?=
 =?us-ascii?Q?arx16fambEWMROqDfuDXrGZzluS35CbXVONikfChlGJEKbT38iYaTIBfNVbM?=
 =?us-ascii?Q?gR3uJaIz/Iic0XFItdcc12U1ZH2rQIiHLv3VWkpb0i8H5E9ApgtACINqR3t3?=
 =?us-ascii?Q?ufDRcaTDnWPpaeXNfH4OI2c3byupaqcK8dJUo8bcT9NJWWRfdMIykT6YGx9f?=
 =?us-ascii?Q?QlSRECHE4A/grwrLnapVmAglg5a/wqWNdAOkEBZUPoGp79zQFPF9cG1lZEd1?=
 =?us-ascii?Q?SF9pHAf3CbazINAZh6tc94mFMnSnUqQzvZ/BapOrCKAbN0kYR5bR96i+BUTf?=
 =?us-ascii?Q?n73ewRuRH7B+bn/M1Gi3fPVSPQJtQxo3Z4lwK2/SW2CY/9uaYL2PZ9Mna6ot?=
 =?us-ascii?Q?CLItU7dibfH/MOS3JWctG75FMMDoAZFGKmyS/wgsHhpKlQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A56DAA65E17EEF4BAB7E49CF66D00BD1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d307bcbc-1064-4b78-4cfa-08d8d8ff503e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 20:03:54.6171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oo6J/IyPSPv6zLGW7ZsG57xPQIWYPx93DVNNKi3BnXdy3058nd94bZXjic0WM1j4owT8llNFafEJE/Cco2zPGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2439
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240153
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240154
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 24, 2021, at 3:02 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Wed, Feb 24, 2021 at 02:18:18PM +0000, Chuck Lever wrote:
>>=20
>>=20
>>> On Feb 22, 2021, at 6:36 PM, Timo Rothenpieler <timo@rothenpieler.org> =
wrote:
>>>=20
>>> This brings it in line with the regular tcp backchannel, which also has
>>> all those timeouts disabled.
>>>=20
>>> Prevents the backchannel from timing out, getting some async operations
>>> like server side copying getting stuck indefinitely on the client side.
>>>=20
>>> Signed-off-by: Timo Rothenpieler <timo@rothenpieler.org>
>>=20
>> Thanks for your patch! I've included it in the for-rc branch at
>>=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> So, I'm sure this patch makes sense.
>=20
> But I'm also curious why it's not recovering.

Agreed. This patch is not a substitute for proper callback channel recovery=
.


> What I think should happen:
>=20
> 	- clp->cl_cb_state should be set to NFSD4_CB_DOWN.

I think it's set to FAULT.


> 	- This should cause the next SEQUENCE reply to have
> 	  SEQ4_STATUS_CB_PATH_DOWN set.
> 	- That should poke the client to recover.  (Maybe by sending a
> 	  BIND_CONN_TO_SESSION call?)
>=20
> I'd be curious whether any of that's actually happening.
>=20
> --b.
>=20
>>=20
>>=20
>>> ---
>>> Did the same testing with this applied than before, and could not
>>> observe it getting stuck, same as with the previous patch, which I
>>> removed before testing this one.
>>>=20
>>> This obviously still does not fix the issue of it being seemingly unabl=
e
>>> to reestablish the disconnected backchannel.
>>> An event that disconnects the backchannel but leaves the main connectio=
n
>>> intact seems a pretty rare occurance though, outside of this issue.
>>>=20
>>> net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xp=
rtrdma/svc_rdma_backchannel.c
>>> index 63f8be974df2..8186ab6f99f1 100644
>>> --- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
>>> @@ -252,9 +252,9 @@ xprt_setup_rdma_bc(struct xprt_create *args)
>>> 	xprt->timeout =3D &xprt_rdma_bc_timeout;
>>> 	xprt_set_bound(xprt);
>>> 	xprt_set_connected(xprt);
>>> -	xprt->bind_timeout =3D RPCRDMA_BIND_TO;
>>> -	xprt->reestablish_timeout =3D RPCRDMA_INIT_REEST_TO;
>>> -	xprt->idle_timeout =3D RPCRDMA_IDLE_DISC_TO;
>>> +	xprt->bind_timeout =3D 0;
>>> +	xprt->reestablish_timeout =3D 0;
>>> +	xprt->idle_timeout =3D 0;
>>>=20
>>> 	xprt->prot =3D XPRT_TRANSPORT_BC_RDMA;
>>> 	xprt->ops =3D &xprt_rdma_bc_procs;
>>> --=20
>>> 2.25.1
>>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever




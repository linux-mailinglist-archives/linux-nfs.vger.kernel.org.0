Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E258CED6
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Aug 2022 22:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiHHUGg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Aug 2022 16:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiHHUGf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Aug 2022 16:06:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ABE18B0B
        for <linux-nfs@vger.kernel.org>; Mon,  8 Aug 2022 13:06:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ItYWn013727;
        Mon, 8 Aug 2022 20:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=t30hakybe5IHEfwnR3efvbRcL2+xZFJaJbHZFkDvhks=;
 b=mW6r2VGXkFk7PXi3b80HNysr6YONL57ff93Jxx16PfWApjJQ4ViFMw3lL1FcuuX0uzjm
 TgCWKBEeEiPsYYK1KO91OO4r3ow7sDCuq2IPqV+xQ/zCn/yshUjrGDMsNrINzh4YABSr
 OP+1IAwhEsYVOZqOlRpaGbg3Ghw72MP7AGOaOScTeK9N0lIu9HlqlTqc09dv8WIr7Ssf
 w07F91AuuI0o+/yUwS8V38Yqc3rN2pk1YgoHdC3ATd3naDsiqUQzkQUj7HoHtYu8BfaS
 ifMQ22LgvOVgUwNhG/6NWEdAy2l6xh3rtxqSVpMQn86KBrS1/xK8mwv8uybp4hOKCxfx qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsf32cq84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 20:06:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278ID651012552;
        Mon, 8 Aug 2022 20:06:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hser8a7j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 20:06:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoVEbvVoFSxHSSQV3Jl+CQB+ES+x+FvjkNt1H+nMO8mUxmOt3zF6P/OcP+nZ2hLt3DkLvlUk+kNcUXN4wOVjM2jZtqfhnLrhCrIUCUcN63eDVqNlyau6V8ABb7rqdQHMpzTmfnxQa2iFUsa4yUOeyOoj8Ui51PhN+F/gUsyWJh4K1GGUB+BZu+Ip81ieXFucDZ+PbLgQ2nXziEGY+40tSE5d7/M0LNpQwEpOg2VA/3whwWDZSFbWU5hgRqThJsAlWj1ET3dkABOdyJVLhGmLNInS59kTdO3T1fVMT57DFDN6/UU41VdO4LKWJh/AXj6Kr+ul8Ekd6QEVy5nG6yiz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t30hakybe5IHEfwnR3efvbRcL2+xZFJaJbHZFkDvhks=;
 b=YruEV0+PazW9rgoxuX5BAWZGTd/XiRk6V/Wf3qbsfs0HbXqkmZNV+gp83nyFDGDi/hnjC1fSDoCQ7awNV6+4m12syAPV5DOaohDvscq5maK6uliB8W1xsHhN0ABSARc1XXgOc1HU0a/cfqkHHzF0PJQDDp99Fri+9MUF/KwihZqXC96VpBhbZe1odblomc27R/GQm5iMOh2IDGgUcrOnrvQBBouGYN0NQrn+0wX3cohN67JJHCtvQ7U3Cb9DYwf3ZbzTZAAzEc7KMs5uNfnNmR64gHBJFw6GPuB75fU7MrMrqmOUzbaY7ejlndma7ERvsDAXmjnd6oHMQ85VLuD3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t30hakybe5IHEfwnR3efvbRcL2+xZFJaJbHZFkDvhks=;
 b=S0ug6TLUlzWUplaCC24/ygd6ip9WdTYMEIcpUaP0p0XJFQPUJcBUBbnbPNCBBkNm7kkRu/fdwHRo7lsVhgJLIPMGAvArxffVUIDLhI7oT0BrT5Kuhh/gOuzwEvbd6xCKwd+arTi4bSzcKe4SvGSsE+DNtTqCWdV9BldJyG+Xut4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3031.namprd10.prod.outlook.com (2603:10b6:a03:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 8 Aug
 2022 20:06:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 20:06:23 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] Wait for DELEGRETURN before returning
 NFS4ERR_DELAY
Thread-Topic: [PATCH v3 0/7] Wait for DELEGRETURN before returning
 NFS4ERR_DELAY
Thread-Index: AQHYqy4gRT0K7GpiEkGiJB7utcU4AK2lWIgAgAAVxAA=
Date:   Mon, 8 Aug 2022 20:06:23 +0000
Message-ID: <3D17DE4C-73B9-4635-A102-72955D19CCDE@oracle.com>
References: <165996657035.2637.4745479232455341597.stgit@manet.1015granger.net>
 <55bc0656a841cc1229d2b1594d4f9eeabfd00ae5.camel@kernel.org>
In-Reply-To: <55bc0656a841cc1229d2b1594d4f9eeabfd00ae5.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 526de93e-2500-48ff-bd5f-08da797977bd
x-ms-traffictypediagnostic: BYAPR10MB3031:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M9doAAMlmlLnad17NJn0sWZubArEko6eMJuaNTJ1zwxPy3myaGysqVxPBqtV6WJ7zrXAhBzO4sUbCzM9EJFK6G81gQ1H/TPaPdg3br5QrVRfWgkZtGyi/fcoUeQ1u/qTXuU+KxQJ1u5ezFv53RwC2DHVy9fzmVhT4eO32MiXrxt3GbUl5EVGGZNHph+Ay/QZJjs8JiULS7UzUNWApGz7nFMkv2KHaCX1RiM67f3CWCMYixp6BE9LO3yz9dh0AWmbN38tbLfr9HlmIyjGJMTooAmIn4lVJ7J1ONr0XkzneYfj7eDZ1PwQPtjpeUnmzHEs1VF8Z/6qLh1QVMRiGQSgUlah5B03/tg1fQyPez2MWoGi3+OGjcEkwQ5QfS8pBncjByt3XTTQcbj/a9QF7bClcoIcjLbL6S/KctAU312csi+Kg7HgE9j6xb+9i6vnmPR/BODKxH7D3qTJHXmzJvjFnkFRaf4ujKs+tjXTMc8+hjgUGWVvpixhNTnIzCA0ZlDDhK4YOp+L8phi4Szlac27ff1P6Kq/ntsK1e4MgMFjA3P8Moi3AoT8Lk4ZUVNTEY5tGU/03NhjjDZtQBxyFx1L8pWlTgonZ9R5dj2zcRSMht3FQz/x5mq8EAHMT0CaQJsCV2Roc+FF+gl3stRj1GjroXPQFFD4engVqvrWhT8MekuRJ765W0ubK+FqbsyvXHXRmz/8IGRCRzQuhT8ywnRRCG9hAY6IKR3UTnMsVY8qTFnT6XDCZxu6bv/OjnJhm04YBEz1rKtKOTwfhpsitVxMOeLaFqUqNTjDWkk8VJSXl0Oog1RB1mDSd6WYjEKRJOAmoX5rg7mjc2k3QyC8rPLD5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(39860400002)(136003)(396003)(38100700002)(38070700005)(186003)(6486002)(2616005)(26005)(6512007)(71200400001)(41300700001)(6506007)(53546011)(91956017)(36756003)(478600001)(86362001)(66446008)(66946007)(8676002)(4326008)(6916009)(4744005)(64756008)(66476007)(76116006)(66556008)(5660300002)(316002)(2906002)(122000001)(83380400001)(33656002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xD4OeIQkOCdPofApc4NI/vFuSWSGjJQvJmF2si+Ewv7ehJ+MX0xAuM1k8OYk?=
 =?us-ascii?Q?xKLVN9AxaAtQk4NaTjP1Jhevjxzb11uPfk3g3MkU7h8tJ9izXA5Dy6KGwRxY?=
 =?us-ascii?Q?YEwUl3W6chmQND6DVEQXbgOe3EXSKX60lAKS3OzgPh4lM89xBz86op8bOSgw?=
 =?us-ascii?Q?MDsfPlZUu70ofek1j0Ld+MOQ7h6Cdpu/DbhPauABCkeYbRlDa+qs18rq1xiS?=
 =?us-ascii?Q?GOaOznUD5zo5rBjQZ6V2r44ahpBHkuahGZlYaqpumb55RMoeKt0qsMq2kPs9?=
 =?us-ascii?Q?vNus2jyBUqusxCSCX80NKF2SEutpq+JP5xeef44Si1UHtaLgA7TmBv9iAA6a?=
 =?us-ascii?Q?lNjg6O5wRQI3TKzxHXpqLg04h2Lq4e2dYA3yqAQ+PIZhnVfAXTbIi5TShUkU?=
 =?us-ascii?Q?lrI+X0cQYtVoJ/7ddLTV0CpJpFrPZ69cugM82YShTrQ9DCoghgORxqffDGse?=
 =?us-ascii?Q?Tl0Yygx0tkeuKwmrBtxxqwgadWY4poTYl3zoadKOh8wfrVZSOoxs/4nzNaEY?=
 =?us-ascii?Q?G3myF4Cs2vb0omt1x2orxELlAN3jSF84oYt3uuAI3s8JZyBmcEdY8SqbXgG1?=
 =?us-ascii?Q?jMO0dgxwm3Vsak/nEboL9ePWuJmwrJQ3w1CD8smYbvv4kGdQc0e/W52Atfac?=
 =?us-ascii?Q?aQ6Lb73We+yaWvC+94bOHVSJeFnHmvtC18zJTRu6DMblcr06Dh2LcXHkmgY4?=
 =?us-ascii?Q?iX4Yk+APIk6VkolRuRizey50NvB8Lk+FYkUS8cXa8uB1wfG6cA4ob2gWV5Ed?=
 =?us-ascii?Q?w4+ktADutFvMIMGcp02iv/owWU/1r2cTO3aP9jbOnkO30rH7bLb1Cghmvbgg?=
 =?us-ascii?Q?oDNyyLjX/NMZ6WTe0JPwDl+PPiwejXH1IJJxTkvKfYux7K+2EPGoeRPLDe5A?=
 =?us-ascii?Q?Ku3fexc99iKnLC99pQXXEHDmDsXJ8oWrwYMwchO7R7e7xgPiXUi0P6dD4hIi?=
 =?us-ascii?Q?g83OVWyobxyWR52ItOce057kJ/PjwwUnc5Jii0S6TBMBnRlZW0DHKmx4/fEo?=
 =?us-ascii?Q?nnKsOFx5002bqauC1Q8iYNCcgO61p4CbSVJ4R9Rfc41LJ3V8/J4cJUWIMhhT?=
 =?us-ascii?Q?YisXOXXbaQdm9oX6OB6QZus0ESiEVcnU1Bm5iOJktMQN/881owiO86+qwqLP?=
 =?us-ascii?Q?JR9iK79n9h8728U5JGJiiYduWyK7pedEWtzCY0Ghdhp9SB5KKQBj7SphYDoC?=
 =?us-ascii?Q?NSJtHy+h64Sql87yNk4riB4MbXAqlpswDkrA71E57tG7KeqhIhHPsF3AOYq2?=
 =?us-ascii?Q?DtWgwKTE/T5RFFjdmwsXM38b8O/da3uhRs8UfIXZ0orOoDLIohu6mGnPzwyQ?=
 =?us-ascii?Q?zF91JLu0j9r1XKDdeu1kzGzqz/6D4cyxg+UqeoGLYNeIkgI/krY+TpZxeQmZ?=
 =?us-ascii?Q?dpf+kQ0YaujHbaf5fC6Mt4bL2UFsX5IzWON9escnWonqWN5ouUnaZ5/Nl5V+?=
 =?us-ascii?Q?SiR8ytbZl0VrmQ1pM377y3UDVUcrW1EVHKRzBGdpDGGIdloJdRlJhs+Tdy8S?=
 =?us-ascii?Q?g8S7A1gQwx0KdtxOq4J8fMNQ4ArjVTAid9Yajjpf3xrFrWtrM9+rbznA2cls?=
 =?us-ascii?Q?wbQNntHd7eg7AexAbb2/8xOmNtmcQp8NQrDAithX6bHiGL6vH5kgnLvuC24C?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <867C4BF97E8E264183F5E00EFA6CDFBC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526de93e-2500-48ff-bd5f-08da797977bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 20:06:23.2805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +66MpZkkIlX6NOgkM4dqkdz/5y8/ZLem9PYkFHbW+RtzU7GWq05YXoAn1Q+XS2ZP7K6s3ed9iBatx5zUXiqMyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_13,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=906
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208080088
X-Proofpoint-GUID: BcXj5wYs882bXKWtj_wjLTztLCyb4vj4
X-Proofpoint-ORIG-GUID: BcXj5wYs882bXKWtj_wjLTztLCyb4vj4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 8, 2022, at 2:48 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-08-08 at 09:52 -0400, Chuck Lever wrote:
>> This RFC series adds logic to the Linux NFS server to make it wait a
>> few moments for clients to return a delegation before replying with
>> NFS4ERR_DELAY. There are two main benefits:
>>=20
>> - This improves responsiveness when a delegated file is accessed
>> from another client
>> - This removes an unnecessary latency if a client has neglected to
>> return a delegation before attempting a RENAME or SETATTR
>>=20
>> This series is incomplete:
>> - There are likely other operations that can benefit (eg. OPEN)

> Does REMOVE need similar treatment? Does the Apple client return a
> delegation before attempting to unlink?

It's certainly plausible that REMOVE might trigger a delegation recall,
but I haven't yet seen this happen on the wire.


--
Chuck Lever




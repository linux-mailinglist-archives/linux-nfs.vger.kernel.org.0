Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54E442297
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 22:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhKAVZ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 17:25:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30820 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231851AbhKAVZz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Nov 2021 17:25:55 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1HrD1u008642;
        Mon, 1 Nov 2021 18:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xnM5IQHLloBEyV3AKdWjKih8xfORigpVh2JhhnthsEM=;
 b=M7XTNeHBQu2tz0rUPwywaW8gJLyGgTFgEMkcaaiBfb2rjtlE8cueuUuy4RxU4eGPps5L
 MRhU7rKp1T8QgwUb3NNg1UrDuRz+fRbZ1goz9lQHv2I+/6yfRQzQCU2fyoReYe5Z6m6F
 uxU1GpKB1LSAvYZOraZugzcERZsafw0hJVDZcZmZ95fP+RpS/AIXjfVXrPXp5R/PX6pp
 TT18t02Q9Cd/15I3UGwwXcz6n9cAo4xwM7UJkYVfpV6KYJcyIPdA9z4yzjMTmVu0h5N4
 wN7YgPHeJ9Ru+3Jj/0h9+AA9cPiZcZOODnV5+R2W3q6kKLMolhE7G8+siD4JwPGv5jaW aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c290gucw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 18:44:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A1IZpHa003758;
        Mon, 1 Nov 2021 18:44:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 3c0wv376xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 18:44:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YalVqOKbgMUvprgQo/IcEs/KUDuflRhTuMi38gXjdTDqkwz/MdpU7Hk0+j2FlD/V0E1W7QoMxHiH+E+V5F84nmU24OvTCTqd0EUjznR1nNm8YzDGcK2MR2Wb+wqkmwidEJxaUEuQok2xNpDUGKxqCQ6fQvt8On/QJhymqSSMEdrgST9opUSxtH7Yq1LIoCsdHAnW/z78uwW9Y+2g1uhVY2uNhhjcj2Es/PL+3UcgzFx5JQzHkpeDCqi6zyfgK/Q42YrZVkaoE2PVZBHFJhfHLPFL9yoLIL+BxfYoA4yZDfeSPWoTvK7y+zI8nOZlawHxkLQOnvpQSNo6YoPxCeFZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnM5IQHLloBEyV3AKdWjKih8xfORigpVh2JhhnthsEM=;
 b=a1zu4mJq3tO84jYGFpTGV4wKs31pSsrI8FGhFIh4dWwYJKl/r81itPVTN+esKmcSYcLXUE6hAPtkUgFbpD3yxdbiQMNbdZhMi1o5jlKUPHGBQBKnCCj8VKWCNllJHGdu4pUfwU8WEG2dHREMC92sSnc9+Jqoq2/kgGatCNG43aB4D1DS7wEVUQNsodaI5xeIS61a1Fk8l18c3eC8I1AcKm84478x5UNFYF3LoSMjCz3tTaMRbsfk8NWD35QPnYScgoI0VWrWUbSGm+qCldfWD2pwml2ivLLaL4xF6PoO1E5r3yipLNMq8n84i6f1UT8MDYeDqIIfz2K/EoGZoqDc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnM5IQHLloBEyV3AKdWjKih8xfORigpVh2JhhnthsEM=;
 b=CNSasABva83txVLuVxSSLsW0KcDLo3GKBFH9ygMLtPR0AYvscsruIx6i0MQ1hT4jQXb4ycJjFAZOooMO+vFgjPJyb2bx0Rz29oQ1t0gbH3+bN9HaXy9dD4fDXNqmIS3x+dFMU/hR1BYi9wAvUtljTWeXwk/37Pj+hsBlgUHxfWM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 18:44:17 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2ded:9640:8225:8200%5]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 18:44:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/1] Enable inter server to server copies on a export
Thread-Topic: [PATCH 0/1] Enable inter server to server copies on a export
Thread-Index: AQHXzAr3yIMqaUdei0uEQ5nE8lcyw6vp/mgAgAATygCAAB03AIAADd4AgAAdDoCABHh4AIAAAskAgAAU8gCAABztAIAAAWYA
Date:   Mon, 1 Nov 2021 18:44:17 +0000
Message-ID: <F1C2437C-ADE2-4CF3-87B8-8FF818B35146@oracle.com>
References: <20211028144851.644018-1-steved@redhat.com>
 <20211029134534.GA19967@fieldses.org>
 <3e928624-6a7a-8583-7ea4-4eef9c22488e@redhat.com>
 <20211029164058.GE19967@fieldses.org>
 <65b31c94-54aa-5035-546c-75eb0048ba96@redhat.com>
 <20211029191435.GI19967@fieldses.org>
 <ce34c1f2-a0ad-fcb0-99fa-a1ccea8abfd7@redhat.com>
 <20211101154046.GA12965@fieldses.org>
 <93DAB7C7-D0BB-48BA-9BFF-2821D88582EA@oracle.com>
 <20211101183916.GA14427@fieldses.org>
In-Reply-To: <20211101183916.GA14427@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c28f93a-ffc8-4b28-0c43-08d99d679bfe
x-ms-traffictypediagnostic: SJ0PR10MB4624:
x-microsoft-antispam-prvs: <SJ0PR10MB4624DD7BE3F38A20AB2E74D4938A9@SJ0PR10MB4624.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKCmwqw0Mr04rbQHL+PLjvqbIcHCIVJ34Xyw6uk06OZk31Bli8Caee8/4UjUeVVg9oBEb32+sGG/CEJiN4fBdqZ2TTr65LWv/4tycjN+qaxOAa8WiZ93WIbmY5Awh/BJ+NeMq28dzC82mVaY4wPiPTuLX/X3w0JkM09BmkSsat4SBvTkM8SSkUqOzgdV+Y4FlyiTgFYFS0xlyXIFKz2JCyGT1MY2HWXtSK3cOeYFbofv806g0cOo7g7OkX5XZIayIIkWXibIJfs20fcLR2k/jgjfcQb8fHYkZoxpq/Ung2EFTatS1M6/hQ4KChlWuVg9VjQxGdZe6mlC77iEKQZb3wHIVqjYi44nk4cMaW/UFZmWS6XbLEKroUbesF5pNHYHmtSzJBBnUOd/lPCCmJV0JQzxoKWtAtR/2p8fU/+XkQ3sVKGrtY7wGzM1bMXzpbdTISOtT6yGLGIEaGANrnLQ/C/zsbK3HNGAJubiUsrvDM9Xn0ypb5MxpGT4w0+Fbzz0IKspMoWkk4/4fLoBR7YgpV/okiZeq7Q1UqJHG7Ru1Zx4NUa/rltoQhbypQGqtLJo7/3yTO88hAG/5m2XxEDeihi20sSNYKEltfXrR83oGlzAd25fZitCEQRJSjO7bXyfSpQc+1JJERjNfFNmC75n0QzKE0f1QMcq0MM4T/VBjMsJgY2asjI023Vq03D7bnsyy4mx2V2gksZmAa13TmA/OMhdtUREjLJTBRx8DJiVOGD+u5sOhJTtesbby7sntF7l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(64756008)(4326008)(316002)(508600001)(186003)(66556008)(66476007)(54906003)(26005)(38070700005)(91956017)(71200400001)(2616005)(66446008)(2906002)(76116006)(6486002)(83380400001)(6512007)(5660300002)(122000001)(8676002)(53546011)(6506007)(6916009)(36756003)(38100700002)(8936002)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xh0zGmvj3jO7O54CYniEPML4ndpNAc9qh7Q/lT9LM8ooxtInJPXcUfjQC4Zx?=
 =?us-ascii?Q?aBGJLW0C52hEXG+oihT5W4qLDcZ31ZDDVieH5zgDbg2dBKWyBnhwO4mwy+ei?=
 =?us-ascii?Q?DrqRyXuaKACDRDbNgLToa01Ew9/W/WTaC1Q+XpO5wtKZfvjTjiBFBVMRN+lZ?=
 =?us-ascii?Q?ry/Mbf1EMX4AsOVjNGoBAlrhDSK3mW3xgwqqTRxYJjWPn5dxMuQZOlFODRVo?=
 =?us-ascii?Q?1Xpf0Cr51uhu8GuzEe8su+tuBa/tQXHJF0nu1tWzWgzbitmWGAzHdKZq1uo2?=
 =?us-ascii?Q?+USRRUimg63LqOhmcYxMPMOvnx9Z+LfmKb5Rq1l/90dI6uKzwVKZhjOMLTGZ?=
 =?us-ascii?Q?SBxWx1lM+17SE0+G5PbD5ERQThIvlysyVKO3Dh6nGhp3u90UQJpsSwuYerCK?=
 =?us-ascii?Q?pvmu3VcL2uDo+INheEow6iKokbbieWwAJ/hKnRUi0dom52W1zs6DmhhkrxpB?=
 =?us-ascii?Q?0AltG/8ifvUzFshuYArNkeCAV4bFxuWuGz+SEIAqsgahp/G+K3Ot9ZQC3Ddn?=
 =?us-ascii?Q?vqPZTgIvjrobL7VNia4fzVmx9K3PCs0Opvs/GnC+r7xadf72Tm6h/vQrpHyW?=
 =?us-ascii?Q?nTK0L8KEJPISf6RwQhrIg3qH5Y0LMcyBcoEt6ZhnxNxc8aG6fXFqo0u959Jh?=
 =?us-ascii?Q?9O6cJvk8hgSVccJIaxs3+131I6e5DSWsCpTvOve58yNpO0Zg5nRkmgLwn3ZZ?=
 =?us-ascii?Q?e1i8ka9wsmcwX7Rvrd81Fyh0vCfAVf8+FM2mHaPycAu9/PIVwa0r/46GzyCS?=
 =?us-ascii?Q?kQeXDXWQ10YNvuRi2waucS3UddTqHlm1W2+qQnvBlLnfxszweD0j9ruJV6SD?=
 =?us-ascii?Q?gkWUu2pSARLie5Evdc5WitXm6JK7z7pBdJ9feBm4rDAestA7uieL65bAXqa9?=
 =?us-ascii?Q?tVdLNbSRdpbL0dJfMH7YCvHJfpe6EyKYZdIFo+U2RnoKnLcKypq8copJtWLf?=
 =?us-ascii?Q?TSGirDImL6hydLiD+oKksY1wasXbcjrT+a4AkzK9+rehQJJMRMpXgx/M0C6k?=
 =?us-ascii?Q?FOQS3tt52gL5OgBXJ758VW9fZ1TkAvdZrE3ZnWlk0qf0gndRtvzYKyRgerBb?=
 =?us-ascii?Q?ksiLGUecxx9i6PhyKqYwirjPnQbk33i3ViqxGnfSFMX4OAlISqfQCpULn6A5?=
 =?us-ascii?Q?Iuh3ldg/1N7lchiq40JA0b1oRZuimdyTPunDwmS3NpK9Dws5thBBloIRNY48?=
 =?us-ascii?Q?WZdGFZeuoLDIpRrr+ahftIak68f7MSicmFYgYS1cZOV+6HcKNSLEX2CHyE2F?=
 =?us-ascii?Q?EFmUHmqWzjNPahLT63l94J54NMNM5u1hkoLRs/QAaxfqn6/dXj4iTBdNv9Vd?=
 =?us-ascii?Q?F2qJTmDv3PRqVSCAk/mogcjDr2T4QuDp/LfzMgWXaDo+Cv3b8zkpEnLJS3Ix?=
 =?us-ascii?Q?lSYfM9aZnOGBayM2eMmGos08zuXxjSuWDHLtlQ+b71FprZUgh9igtZWtZpGg?=
 =?us-ascii?Q?MOpJB79hZYuU8OR+yhqgOcMead65uBsFSj1H3rP5NdKOgy3DK3lbiv6NRbk9?=
 =?us-ascii?Q?vM+NAtyNLmyHnWG3Z0iZJ6f5YN+XKn5/qChXZn2MUQ8iN3+UZWPj52/UIxyO?=
 =?us-ascii?Q?VAPFta1DGbX1lQhYnZhGFjI+ZLswzdq9zpZ4aTQPggQzmkNCISQRfNTQMYfB?=
 =?us-ascii?Q?qhN/yNOKJ+GqWw3Hn2aUOxA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC2DF0BF2E4AE4498A0410B6885292B3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c28f93a-ffc8-4b28-0c43-08d99d679bfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 18:44:17.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYzZgf+S99OvwsEknF1AGw+np6tnsAl5k33EdP8JPE6+SnigqeCoVFsueePfLGz6uYY6Z42SO/J3/bc5QzVX5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10155 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111010100
X-Proofpoint-GUID: hfx3MQcVvxO8IXq4gaQAFZXxjoFFDQic
X-Proofpoint-ORIG-GUID: hfx3MQcVvxO8IXq4gaQAFZXxjoFFDQic
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 1, 2021, at 2:39 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Mon, Nov 01, 2021 at 04:55:45PM +0000, Chuck Lever III wrote:
>>=20
>>> On Nov 1, 2021, at 11:40 AM, J. Bruce Fields <bfields@fieldses.org> wro=
te:
>>>=20
>>> On Mon, Nov 01, 2021 at 11:30:48AM -0400, Steve Dickson wrote:
>>>> Hey!
>>>>=20
>>>> On 10/29/21 15:14, J. Bruce Fields wrote:
>>>>> On Fri, Oct 29, 2021 at 01:30:36PM -0400, Steve Dickson wrote:
>>>>>> On 10/29/21 12:40, J. Bruce Fields wrote:
>>>>>>> Let's just stick with that for now, and leave it off by default unt=
il
>>>>>>> we're sure it's mature enough.  Let's not introduce new configurati=
on to
>>>>>>> work around problems that we haven't really analyzed yet.
>>>>>> How is this going to find problems? At least with the export option
>>>>>> it is documented
>>>>>=20
>>>>> That sounds fixable.  We need documentation of module parameters anyw=
ay.
>>>> Yeah I just took I don't see any documentation of module
>>>> parameters anywhere for any of the modules. But by documentation
>>>> I meant having the feature in the exports(5) manpage.
>>>=20
>>> I think I'd probably create a new page for sysctls (this isn't the only
>>> one needing documentation), and make sure it's listed in the "SEE ALSO"
>>> section of the other man pages.
>>=20
>> Aren't sysctls documented under Documentation/ ?
>=20
> Sorry, I meant "module parameter".  Anyway, yes, looks like both are
> listed in Documentation/admin-guide/kernel-parameters.txt.
>=20
> Might be nice if these were in a man page too somewhere, but maybe
> that's not the most important thing these days.
>=20
> --b.

This looks like a step forward to me.


> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 91ba391f9b32..14bc3f0b0149 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3243,6 +3243,19 @@
> 			driver. A non-zero value sets the minimum interval
> 			in seconds between layoutstats transmissions.
>=20
> +	nfsd.inter_copy_offload_enable =3D
> +			[NFSv4.2] When set to 1, the server will support
> +			server-to-server copies for which this server is
> +			the destination of the copy.
> +
> +	nfsd.nfsd4_ssc_umount_timeout =3D
> +			[NFSv4.2] When used as the destination of a
> +			server-to-server copy, knfsd temporarily mounts
> +			the source server.  It caches the mount in case
> +			it will be needed again, and discards it if not
> +			used for the number of milliseconds specified by
> +			this parameter.
> +
> 	nfsd.nfs4_disable_idmapping=3D
> 			[NFSv4] When set to the default of '1', the NFSv4
> 			server will return only numeric uids and gids to
> @@ -3250,6 +3263,7 @@
> 			and gids from such clients.  This is intended to ease
> 			migration from NFSv2/v3.
>=20
> +
> 	nmi_backtrace.backtrace_idle [KNL]
> 			Dump stacks even of idle CPUs in response to an
> 			NMI stack-backtrace request.

--
Chuck Lever




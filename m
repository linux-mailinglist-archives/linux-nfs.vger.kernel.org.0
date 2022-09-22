Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27815E64F3
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiIVOTE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIVOTD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 10:19:03 -0400
Received: from mx0a-0002ee02.pphosted.com (mx0a-0002ee02.pphosted.com [205.220.167.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123B7F08BC
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 07:19:01 -0700 (PDT)
Received: from pps.filterd (m0270671.ppops.net [127.0.0.1])
        by mx0b-0002ee02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MClGep029664;
        Thu, 22 Sep 2022 09:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fedex.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtp-out;
 bh=eXxHmfgkLnbyxovxiPYkqMxkD4uAfLLkyw2D6ddZgfo=;
 b=bx1SHPCJMWHBo0LuHxqRyXXGk8bSegc2GIENdFHyk56QG73S4abssGGrgyAuy0K4lDXU
 mO0xN85jWVaCE1YpfiGZNJmRTPxhAVMeL8Kq+VPKDMRQTWAKtlWg/OZJlf6e2B6leFHq
 kWr+1cTR4QkwRa9XIRtKPBncBkSrujsROJjcIZuomK7k7ZLR7nMyNv5Xpfnjc53D1fOm
 8QmAJBd2uYmzG2JfVKZx9sEFSxvi83akUOUCjS/agGdJ/hSiO6UZS4cGJGewsO+84kiq
 5Gi2NBux0MxaEJVnlA6DgkCQJc2VwNzcgazthv2KICJrRENINM70dcOfaBUT+HBgw3X/ 7Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0b-0002ee02.pphosted.com (PPS) with ESMTPS id 3jrr139ahw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 09:18:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAT9AOmS2NgDsRpVswiZUuDGuPYtUHbbsQfUOwhYSQBZnFL5nYcnSd3OGFJuCVUg1GjXQIwCEjxwSXFdbWAJKfQ/kQvQ1yNhkSSc12ehodhwZxjxYcEP696q3dETf+IX08JHNd08cqYFnHAR4QeYOB9IZb+sb2Xs00nNXnC/8HJX5aN7ZUAjKE5GeSzUxJEcyhoYuUIVoDlYDkkyuOcKsfywTmkgX/DHtAwjZ2M4BO7WSOmaVqM8iU2GquyIJY9/toqVtCBxPkeJ3ox+sw1h48ULU0p/rln0c9386RlwVqlEHBWYe2cixrBHo3vyJKyYYOllFApPYpqtMxGqkdtlFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXxHmfgkLnbyxovxiPYkqMxkD4uAfLLkyw2D6ddZgfo=;
 b=QhQcRs5g7G00gDLYOjSGwA2WTYTk2qnnEjDSo1LckDskTucg+cj8fMf0PMQlJ2qJgjcKTyvBEWakm1dbAgfl8aP1drMKxCoNpSuTW5YFMmuNiYsGNTdZGWBmawqpNn2Qj+ebFuIgf9KWEqWoDn+bHxR3dVXcBnzT17CZB41U7QBRjdSAp0I82v+s+lkyf6Kew7pBGgA5dw/iaPaxUH6vy1m+AGcxnJdxOxY1TKh+qJkMRNwwyCoYmgkx2s8NUEe7uDLuzrZGPXboZp5InOXVlLh/V1xvewbSRKy8iYSFCpTQgR2H3kqOThAE1xCi5q4teJIW6nK6sYMxpvv8DghAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fedex.com; dmarc=pass action=none header.from=fedex.com;
 dkim=pass header.d=fedex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=myfedex.onmicrosoft.com; s=selector1-myfedex-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXxHmfgkLnbyxovxiPYkqMxkD4uAfLLkyw2D6ddZgfo=;
 b=XgKzvHBxfmTY7jPPi0sJoZXlGE1r9+4oJrY4gl9Gqa7Z+kX3gy7LG7t79aY56Peje/VetO7ZwOvBIkg2iJ2nNy14KaH88UEK+OvDqhjvjE/2UWnhpF8Xo1/ieGmCYv5PzEJ3HySnvOstRTybzy23tpxBJQHl91Aq6E5noUSpwNU=
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Thu, 22 Sep
 2022 14:18:58 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::f182:c1ec:d17d:43fa]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::f182:c1ec:d17d:43fa%7]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 14:18:58 +0000
From:   Alan Maxwell <amaxwell@fedex.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [EXTERNAL] nfsv4 client idmapper issue
Thread-Topic: [EXTERNAL] nfsv4 client idmapper issue
Thread-Index: AQHYzoyLB0ZCEFrXiEO+WVUdCpVZ7K3rfeBg
Date:   Thu, 22 Sep 2022 14:18:58 +0000
Message-ID: <DS0PR12MB648637C3D4E07C6FCA90A0E4C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
References: <DS0PR12MB6486987EC76AD88C7A80D229C84F9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <46FAEBBD-50BC-464B-A983-1DC2232795C5@redhat.com>
 <DS0PR12MB6486B941F1EA96D2634CED63C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <812A1C59-B489-4D6B-8673-15F5C86A99D0@redhat.com>
In-Reply-To: <812A1C59-B489-4D6B-8673-15F5C86A99D0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|PH7PR12MB6884:EE_
x-ms-office365-filtering-correlation-id: 23c0180e-4d9e-444b-2ad1-08da9ca56397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: addfM5er7EjQZIB59ZQ/FFiJwhsYaa6HwVMd9lhmgFeTOeGdtQdP+ntCJW1Uxr6hqLrM42St7wgKg19bOcG/BIuIrk/FxsS60oyhBIO+HslR9FQvB7wM2SeZOYiJCFe+kcKDjEzwa4LtArQaexqxxmpA8YsT8brJzA2Llh1zwkBP350EYAL19b+X6rO85513jxcm0abwwnzxdCHsrQE69mdYcCtkWnmwAGzBbkOdIZBjzBpxMRRArHXTtgvxuAkCG0+lfLW9+Ui+JesO/cWNIWzWOxzMJ1OO/X83YqIVbCdbiRhyYKJKt6svjoogxtuhqcMXEPAKmggGjOJAQ/1meK6Mm6HHGqvqhIjxlvMxo2nHxojH0gMj0L03LzK/mdpkDet2X/wHvGcQghLlfKQS5dIQJOOPha/4BYdfw8wO2isBfzBcgX88X4yvV0MAR5mcWFUF1ZShX777GWMjZJPfSsidFPdoAIIGq8MhMBUzh+M/zFYi3NrYJCucu+AX7T4o75P979+c6Fg+vQ2NzmX2ALU9pQL2KoyyrkazJYG35LZ5OznMslcAERJwCFwtcAK8cIohtpGNSjkhYNSZYdY1d3UMnLRQwKPTIIgEdjkKTDc/FexqS5yZOKN/R9V+UK4n1iJWDNFa9QfAM30LGmECbU10GtSTA2ayv4FPV4CsPDF7IjvsaWuPnNg5b5hTW1QCjaVw2eId0msmgtYJS/y1dppHKDE4pdzVtPGJBEYxsa5mDQpfoZW4i1M79vC7DIyokG5e2POwZnyzPjDYvE1B8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(55016003)(33656002)(86362001)(66946007)(8936002)(66446008)(71200400001)(52536014)(5660300002)(66476007)(64756008)(2906002)(122000001)(66556008)(8676002)(4326008)(38100700002)(76116006)(82960400001)(6916009)(316002)(10290500003)(478600001)(83380400001)(186003)(53546011)(7696005)(41300700001)(26005)(9686003)(38070700005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k79jJ7Ru0NnDxEMETKuH223RjyvJn5uqbY1+7iFTcKgc/wu7izTK1fPMJT5E?=
 =?us-ascii?Q?N7e2GS04BilEljs+LR2KikAGHIYeMjGkjm7KyRHtgeZTOI/Z8GT68tpR2Olb?=
 =?us-ascii?Q?qWA0njb3Pp4YVafThsHZI8Gw2Wkfbyi8xW/JhQFjDk63jdfexPcOx3mblaNK?=
 =?us-ascii?Q?IZt+/Ncl7oTtdXv+5zBdz1OMcpFh7/0NeSfIfPxJNB+tuSa36dqJFQILqfHj?=
 =?us-ascii?Q?rP64Iy30XR3q6Hse7EhPgN1zoLJoLqDhL9+QRA7zwdpjgzw488gs5Y+obn3/?=
 =?us-ascii?Q?qATpAD8VooIb53PXRhbrcAPOZB08zLhmB/vqtZ13geutIUm32bHv0WL4LFWi?=
 =?us-ascii?Q?1zLQv6MNktp6fhW2LYP8Pt5bGP9FwouZMA9x1VRd2Lrbx8wg9XUQJg8wNJBZ?=
 =?us-ascii?Q?kedw5aUdp/ogP5ZPt8DXKtR5JFUweKkCm+joVIsBtB4L/rB9nR4h/U9zpt4P?=
 =?us-ascii?Q?oxoiC/Nvu0hdyIcRuZheWFOWVhHJ+gsvL/NJb1Kd13gCFsqjENMa5FnIegAV?=
 =?us-ascii?Q?pHGFUaRVB53BlmbZmYLwtZRsmMNw5dxNS0uPewXES4LeiXXq8lJz1VR5Y2eI?=
 =?us-ascii?Q?6yapMhqiWv6gMWZwr6Am60I3un279EwSD1sAJMTZm/i4aSlmleGXbhLsurgt?=
 =?us-ascii?Q?xZpwtux2xb6+mi6YOHTcHPzSgVh6/zHUakTm+u+DJsZ0e+HMsYTAS7syzCDF?=
 =?us-ascii?Q?s5ypiaxdFcWoxJ0phwO1+UmYNtNtiVW5eWFgB64Xw59fLD0QZUQpH2qWlQwM?=
 =?us-ascii?Q?pUlXzRy8dm087v2UfPymdfcsZkT083YFJJivx4U8gCyDWTOGYs9jpotkxiod?=
 =?us-ascii?Q?dnITO1slKkXr0CReu5Az5Pwhcyd3hBHrbat6rcNK4/sMtIkLx1A7oXVQgQjV?=
 =?us-ascii?Q?uK+Lswb7oje4BVb609yFW2JwEzl+GJj6yrNOe9/vvqY/AajXOsQA8Ql5TWI4?=
 =?us-ascii?Q?OpBmFE29StZYN05VSskiHhwQCCkAkT9xi5+WSxp9s0VgMG1z2vlOBPuIuFGl?=
 =?us-ascii?Q?lihqnUZ7rBILz1/HBWN2fGSbmuCCHOuWz7RryZEKoEJCZDb1G9HLaJRV5iDu?=
 =?us-ascii?Q?8naR+7IAhOXVr5FXDzxjtOL2Xj31RvB+AcyaNsaBo1fvAamD9Ur++voXzmmH?=
 =?us-ascii?Q?U1DGO7APbdVVHb/caQkAD8iv6jLx+0EZlElsLssqeTI6QR5VocGjs48A9uYC?=
 =?us-ascii?Q?qD5Rbol/x40l3X8kkr1wuuwU7U9RCR66SFq5FkPFE+dAtLClchYjIr1BQ1sd?=
 =?us-ascii?Q?IbPST+AJ0O/6Fyp5n2bTrdN10VMaI3ojA27wg7RKjXRe+DKBkfFa2JXdQuLU?=
 =?us-ascii?Q?f51W6NNdmVyrOcErkcKGm2JyOjETt3Wi2SeSxgRuzl1Ir1xB4V/TUe/0uDeC?=
 =?us-ascii?Q?K573MHonN1DCM4fGJMyFkSag8O3vejQcsreAN2ZEsQmT6Ky29DVsIQ3vft7t?=
 =?us-ascii?Q?s7kflrK50kUsHOPKGBHKGBc2LR8szJ68sOEIjompKueUlXbWLNOEuz/pY1EL?=
 =?us-ascii?Q?ARJiLIFiGh6HIfYYN4P7qmEYn1VrfYU5ZwOTMmxYegl0demLHOi+a1ZW2voJ?=
 =?us-ascii?Q?m980YDhOGjNo1LQhtZBgKIK6LJSsSEL3EAYSdGiM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fedex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c0180e-4d9e-444b-2ad1-08da9ca56397
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 14:18:58.0578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b945c813-dce6-41f8-8457-5a12c2fe15bf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: by1ARiBc+/69ATz+/6NbE0NpbXtOhjyJDSM/zhkRBfKqW6iOILZ3SWqlxPujA+nlTu+Uuz1D4XjFF6Rhou0PIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
X-Proofpoint-GUID: -cLiZYPJ7C-I1Nf8NfzfMpqZvfE9Eakv
X-Proofpoint-ORIG-GUID: -cLiZYPJ7C-I1Nf8NfzfMpqZvfE9Eakv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=966 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220095
X-Spam-Status: No, score=-18.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



-----Original Message-----
From: Benjamin Coddington <bcodding@redhat.com>=20
Sent: Thursday, September 22, 2022 9:06 AM
To: Alan Maxwell <amaxwell@fedex.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [EXTERNAL] nfsv4 client idmapper issue

On 22 Sep 2022, at 9:45, Alan Maxwell wrote:

> How would the server know what gidNumber to assign if the nfs client=20
> sent a name?

I'm not familiar with this server, but I'm guessing if you have it set to "=
Do not send names", then it also will try not to translate uid/gids it rece=
ives.  Are you asking a theoretical question?
We have server set to "do not send names" because our uid's are fully numer=
ic and that causes similar problem with nfs-client.

> Is there a method in Redhat to have the nfsclient only send=20
> uidNumbers/gidNumbers?

Better to use Red Hat's support for these type of questions because this li=
st is mostly upstream development work, but I believe that's the point of n=
fs4_disable_idmapping which exists on that kernel.
I have an open case with Redhat, they have instructed that, "the upstream k=
ernel has this feature, we can't make any corrections"


> Doing id mapping or better name , id verification, is expected. We=20
> hope the server would tell us, "client sent name I can't verify or lookup=
"

Right, and that is a signal to the client that the server is not doing the =
"Do not send names" thing, rather trying to map values, so the client chang=
es its behavior.

If you're only sending integer gid values, what does it mean to verify a gr=
oup id?  If you want your server to treat the values as integer gids, then =
it shouldn't return an error that means "I couldn't translate this into a g=
id".
Again, we would expect ultimately if the server returns error, nfs client s=
hould do same, show and error, not change the configuration and ignore our =
disable_id_mapping.

> The nfsclient  sends both a bad name and bad gidNumber, we actually=20
> think that should be the case, even and security=3Dsys , there should be=
=20
> validation of users and groups.

I'm sorry, I don't understand what you trying to say here.

Ben


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222B55E6409
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 15:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiIVNqu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 09:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiIVNq2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 09:46:28 -0400
Received: from mx0b-0002ee02.pphosted.com (mx0a-0002ee02.pphosted.com [205.220.167.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F17E722A
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 06:45:57 -0700 (PDT)
Received: from pps.filterd (m0270670.ppops.net [127.0.0.1])
        by mx0b-0002ee02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MCNsgO030459;
        Thu, 22 Sep 2022 08:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fedex.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtp-out;
 bh=LY6DjqqNKJaYJcpAI/2FN0UWe8pouj5i9jJ7Toeq/wM=;
 b=cj/GCxGFFolCF70o1iJQ68MYCSCkku7yZhJkkB6P21yey5MMQLaFSk21n5auFw/egx2X
 ugfeT49gXX1iOIki+RXBivO3zoYkDs4Ek2zrEeBTNht28oRsHiGoq0QXO6VDAm9Jt2Ea
 n6kmpFsNFJmxaCmGVqQrTkZeuAVJ9mr34B00LGyRMa1v8g3nnjfT/AUtnX/jGbkfwAcL
 AFmhcE6Ev1kKhjcGIdCT7zUPD3+n1yimY8u9K03M5eUDtSymEZQNibVepAIUu+31DSRt
 n16jQuf9TcyhP/hggP7pEfXdCh3VdQHF9eAK+K3a97L+iq9D/iX52kCh1JS4NcoM7yo/ AQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0b-0002ee02.pphosted.com (PPS) with ESMTPS id 3jrqp4s0mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 08:45:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wo83maKryJlbD5FhxO02xrGoyjx5otsZAhv5JhMoqnhvisuaQ4sHDbOY1HNQjA7cmAbfIwntoG6MgEIT0QbYBRQYLhfbi3Fr3NoDB3YVIY00ldc/z3q6TRDcZNN/s/K87qOKNqMn3l1hpGkde7khsTcRMsxp1IH3AW/JgW/shK3JBHuFmEFulYHxM1NkzqgogGoDXRKuJY9emTCUy3xLvR1tF2lTFc6PWKB5aUPfZimE6o1sT30Ur16Vx/tNfUJ8poRz34Q2c8cMbEGijFsrzI1Pm1lobLla+PPvwx8NZsPPexZet2rv6v1rzLPB02QCPBcYV66c3tpAlYS76gGI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY6DjqqNKJaYJcpAI/2FN0UWe8pouj5i9jJ7Toeq/wM=;
 b=kEnlWVQySAAuTTaATU8wmxXs9K2EJQ0ppmGwP3Mo9PKUoAO0zJeLzo7LnRZlvslB68GyQ36AB9nD6S+KIDoCkNH66lWMgiiXss/ITiK/d9ZQFLIzu+49XRdpC3g4IGVbe3AfeKaStKlRi6fZrPBBis70U7LYxe4K1Oe+CeMegOyqQyFsXjGQVnviyj3UjoiC/HUpANSEwz3fb1LI/R3JiN9SiPk7QG9l5xuCRQSin/ErHKT6BReMwDm1kMwjsiz/fI/mPI6xEh0/icYzL5yRV4uwW0DonO20Ao9vk6CFTBfduhzji/6R21HjchX14dS1UBpyoNRKhgTom1GtYPTjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fedex.com; dmarc=pass action=none header.from=fedex.com;
 dkim=pass header.d=fedex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=myfedex.onmicrosoft.com; s=selector1-myfedex-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY6DjqqNKJaYJcpAI/2FN0UWe8pouj5i9jJ7Toeq/wM=;
 b=UEomMss6aJ3wPF+Dssh4WjjT3eN7tAklpsMJ4cMCWGfNeQD7tX4+CHOnz/W9U4UuiBgDhgzYWJD7ZtcHLWsPZhrSZK9sVtfTzHWxOekEWsPZ+BWqvW61vzFCEy0f9y5Kq2ysR1bQ9w2xlXvWrnlrCps+J9KYzyO2jipLzYm09Aw=
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.18; Thu, 22 Sep 2022 13:45:54 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::f182:c1ec:d17d:43fa]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::f182:c1ec:d17d:43fa%7]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 13:45:54 +0000
From:   Alan Maxwell <amaxwell@fedex.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: nfsv4 client idmapper issue
Thread-Topic: [EXTERNAL] Re: nfsv4 client idmapper issue
Thread-Index: AdjN5dNv/53QmQ7mSiWe6weV81FGkQAkorMAAAQnwEA=
Date:   Thu, 22 Sep 2022 13:45:54 +0000
Message-ID: <DS0PR12MB6486B941F1EA96D2634CED63C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
References: <DS0PR12MB6486987EC76AD88C7A80D229C84F9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <46FAEBBD-50BC-464B-A983-1DC2232795C5@redhat.com>
In-Reply-To: <46FAEBBD-50BC-464B-A983-1DC2232795C5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|DM4PR12MB5373:EE_
x-ms-office365-filtering-correlation-id: 1cebc5ea-6567-4120-ffa1-08da9ca0c511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7CkdRnTw/Sk40USShmOzsfxu16gBYAX1CocbdXfb54rw3xijg/2vKscJVQYhFCPLry5Ehv9dnvpiAY5X3D6TGnBjfGQHZf458Bdg3RfNVB6dpKDL6AW9lB8CIocI6AfEEENnA2bzXOVi725aCfY2Olztaf6aFfCP8HR5qWWNJbsmbIsHBwzHHMkoMVNavLcp5rY259ztZiwOQBPXpQjjFhC0sslJcmkxolOKnMSKZWKIt3fWw1SXnHsji355bVADyY9XSDLnQ+7VpAXwaot3H0iz2nbh+lfUOUSvKgivjuQ2xMfGfVVMogtlMArhOD7aSrM07lPm7URZ2mvYYKaEOKRkh1Xi2I9ULtaLZ0enprzRFCM7E/1x3zABBlnZNkslKDFFPa6sMGsm1hplqP1bg2kWm2XZXmxlVN5HN2IX7CgOy9tkq5nbJG2P50GiTfm7Vf8DhWeJKDoyY9l35cMDYy7wQEoaM2bG5m8uYYr49rZ7KeTGNwAhGwI5TggtZm/7vuHhek9uKc7u7sgL6BbC4yDEYIgX3zHrk/VvFNbVH0sRVAENRmtk2L9JnITIUYshhmfO9YyxzpyfPNJWkAIEmyJ6r52olxJj8Jqahtr9qklCab8lwJWdMXnJZOiHwFSa+YbbR0cuWZIH4fcelJzXF9dnsG2fNwVJsjAX5bS1zBOp/uJApSAhcePV0KnQAQVwRgAkiR/82baxMLCb8wzx6K+RGGXpJXv7kF3A1NtnhmqKWyVGQ4hgp6drZMOCpoxyyCOCGc6sYtTQHDNI5cWjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(8676002)(186003)(33656002)(71200400001)(10290500003)(86362001)(2906002)(5660300002)(82960400001)(122000001)(6916009)(38100700002)(478600001)(41300700001)(52536014)(9686003)(316002)(6506007)(55016003)(4326008)(53546011)(76116006)(66946007)(26005)(7696005)(83380400001)(38070700005)(64756008)(66556008)(66476007)(8936002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UyX3ABAphOJjsoCG4ggQBGv0ul61Z+YYET8TtxGZrJtBqYjlAQ3w5AmfJ2jk?=
 =?us-ascii?Q?DF1MfaZQXDoO1SKiW6/x7ZrvrDYhQFNBgH4CgCf6qZzUGUU894ewPXpsR0uU?=
 =?us-ascii?Q?NbHhRXdpT7r7Lev9ilT/ALBbAf4PpqRIWdwDY/K+M/8ieqqx4Bs8PVh8P+xz?=
 =?us-ascii?Q?bG98g3RyIH+XETPIXCSLcpMmA0H623/MUumSjFKM8TmkN5UpiSC0ltA+sFWH?=
 =?us-ascii?Q?WfGJSWjxZkXaP6RK/pU7RKxQXZDtLoa2DmI5baNiBTZUtOFXOT1WOULRTwe1?=
 =?us-ascii?Q?miSN3bHXC35Ap6J0X0PQrp0V9Ly0Xt/KV5JQChV4q/RV8l5KElNobz3fsVw0?=
 =?us-ascii?Q?w2hqvxsoFphQhSj99Ow5DHSXa2hQzFuu1CQc8pxv6OMW57VfPKco2ZCrYXpn?=
 =?us-ascii?Q?T2vF1NfJAHT/olffkpCv/OMSDTSLHZli0Lac7UGmGgbAh+Ce3/sxwuFxlpa1?=
 =?us-ascii?Q?syA3n+zV5DSJJcKJYbyg+2gLL8S73pBso5ihp/aKjowrYiehKPSZjyGfKnzA?=
 =?us-ascii?Q?ANyM6RXk2cXJSfK69bDL7XgoGUfv+a6/haABygV/GYkVSuZlwwOc8K+fBPwP?=
 =?us-ascii?Q?V6/z9MPlEu5QXVltAKnqPcb9OgRdrCN2y2+FK2yAnbaEl/Xd1UwwR5nA6ZEM?=
 =?us-ascii?Q?gDCO/aYw6ohF5GkqezImAN2qP+JiCeDidwM78S2hFOM33AKFxp1rnxzFVfc7?=
 =?us-ascii?Q?Vu53BzkFi8wqfKmccyF0EK3ehscKC3N6kBXdocfrtd9/asekdvsq//UBhwYJ?=
 =?us-ascii?Q?vf0FLh0tcpv75rmjTk4BRHaVmWNd94Zh23/4EEQmIkBL02vsgphHSVpNykO+?=
 =?us-ascii?Q?Zszbpa5WkvQQmBcVTKykjFz/Hbtv69ro9m2NpJ8Rh0nd1wUKGUlLdk22hk3t?=
 =?us-ascii?Q?/NG2MaDA2wOnu19flUjdZbgC12n45gBmdO3MaR3YsY4+FaKjL++Guc0vRMaR?=
 =?us-ascii?Q?L5LiVD7x4+D4YkfAyi/h5LUnoVPwkFGWfjN9Cxdxh9tvG2tg6VT0ZwPuu7Tj?=
 =?us-ascii?Q?b6MoThQ7GgsV4i8Aa/67h00jYZMgYLJav6kXH4jVvuo/ZB4BD48j1gbtJ2sU?=
 =?us-ascii?Q?ZUNG9RZi6uiwJFm5C4B+3LqmWeUJe1i0G1XL0vB4hqvqguFJ/RgyMbBpJ3jm?=
 =?us-ascii?Q?vV851/DbV+B5QCiKt8Vu37147OkXPHWBsYXJrKOL+7AqNRxz5gTWKS4abZAo?=
 =?us-ascii?Q?vX96EhIWr2PJdC6gH742+VT2WGaekLOHF9zN+AIp64ul1fbJzIkh0H7IKjB6?=
 =?us-ascii?Q?5+NjrfsQg9UJ7czIw44HbkdAeCEYHvPExgua8YPecd21CY9biL8SNal0/PXy?=
 =?us-ascii?Q?7V6IqxC86pUWrpnijGvyh2OfWH8qx1oWvLqDQ1UeFngSjc2fCBuzRSQ7Je2B?=
 =?us-ascii?Q?0Qotz6P0MCrigwHpwOJb+W0bxKnA80PqoOAL3Z+asQSI/AfAlPZYrtdvjthd?=
 =?us-ascii?Q?H8e8vVxxffXZ0wKesjKG7k0BTN2hYf/VFEblK4csANLxKbQhQmP1HZ83ag+w?=
 =?us-ascii?Q?O5LdZV3GnAwNEohKh/iaM08Kw9fDbgJGdh/U8B6KvD0c7FrlwmP4cW4aanEX?=
 =?us-ascii?Q?iYWcTh63gPBcX0b1fnCdBNVJqxSlKR3TB+57tRgG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fedex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cebc5ea-6567-4120-ffa1-08da9ca0c511
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 13:45:54.1181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b945c813-dce6-41f8-8457-5a12c2fe15bf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFLU+2UrwGOHSqnZUWrmjNxn0PzZQJQd4xNBIKxTh7KxskQ2xjAQtxEmPESSbm4lzLgjWNs40108MzALw6ugTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
X-Proofpoint-ORIG-GUID: xWTIgjeiMwXGdCk6wcfU48AJaAr5IEUI
X-Proofpoint-GUID: xWTIgjeiMwXGdCk6wcfU48AJaAr5IEUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220091
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
Sent: Thursday, September 22, 2022 6:42 AM
To: Alan Maxwell <amaxwell@fedex.com>
Cc: linux-nfs@vger.kernel.org
Subject: [EXTERNAL] Re: nfsv4 client idmapper issue

Caution! This email originated outside of FedEx. Please do not open attachm=
ents or click links from an unknown or suspicious origin.

On 21 Sep 2022, at 14:13, Alan Maxwell wrote:

> I am reporting an issue, not a fault or bugreport.
> NFS client : Redhat 7 kernel: 3.10.0-1160.71.1.el7.x86_64.
> The issue lies with the feature that nfs client that: if an nfs server=20
> rejects an unmapped uid or gid, then the client will automatically=20
> switch back to using the idmapper.
>
> Our particular configuration of nfsv4 server and client are based on=20
> using numeric uidNumber and gidNumber communication.  The nfs server=20
> we are using , OneFS (Dell/EMC/Isilon) has a setting explicitly for=20
> this use: "Do not send names".  We have this set and our testing=20
> showed working 100% with our nfs client.  The main driver for us using=20
> this feature is that our uid's are numeric.  That causes issues with=20
> commands like chown and apparently NFS setattr.  Once we realized=20
> that, we set the numeric setting and everything worked as planned.
> Our problem with the feature comes due to a  simple mistake made by an
> Admin:
>  chgrp groupnotvalid file
> When the admin issued a chgrp, but that group does not exist in the=20
> directory service for the NFS server, the NFS server rejected the=20
> change.  Then the feature kicked in that "client will automatically=20
> switch back to using the idmapper. " Which did make changes, the=20
> /proc/self/mountstats showing the caps=3D0x7fff instead of 0xffff.
> The only solution to get the mount to work as originally configured is=20
> to umount/mount the share.
> Bottom line: Our environment can not support idmapping.  Having the=20
> feature to disable it and that disable be forceful and not something=20
> the kernel can decide to re-enable.
> We would envision that if an invalid chown/chgrp were issued, to=20
> simply return an error, report that the chown/chgrp were not applied=20
> and simply leave the nfsmount as is.
>
> Alan Maxwell | Sr. System Programmer | Platinum Infrastructure|20=20
> FedEx Pkwy 1st Fl Vert,Collierville, TN 38017

Seems like a server bug to me -- if you want to set a numeric group on a fi=
le, the server doesn't need to "look up" the group to see if it exists, it =
should just set the value on the underlying filesystem.
How would the server know what gidNumber to assign if the nfs client sent a=
 name?
Is there a method in Redhat to have the nfsclient only send uidNumbers/gidN=
umbers?


What the server is signaling by sending back NFS4ERR_BADOWNER is that it ac=
tually /is/ doing id mapping.
Doing id mapping or better name , id verification, is expected. We hope the=
 server would tell us, "client sent name I can't verify or lookup"

Why doesn't OneFS just set the value when told "Do not send names"?
The nfsclient  sends both a bad name and bad gidNumber, we actually think t=
hat should be the case, even and security=3Dsys , there should be validatio=
n of users and groups.

Ben


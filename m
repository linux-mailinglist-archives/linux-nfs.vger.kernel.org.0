Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484FC5EFAE1
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Sep 2022 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiI2QeN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Sep 2022 12:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiI2QeI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Sep 2022 12:34:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1660955A4
        for <linux-nfs@vger.kernel.org>; Thu, 29 Sep 2022 09:34:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TGOgYN015714;
        Thu, 29 Sep 2022 16:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=//x5Awz9xmLjLxbpRc1Q9OeYw5+b9HFxLC3HCE4p+cE=;
 b=zH4v9keG/3gCngkUO/StOlQz0hj+DRT5iKSTwRiHg0LxAWVZ3uYlH7xJAKktNecUEiyw
 ftfrJ28IT7nFYMdvomiBvABhfMwvPwHX9/zFpZnJKjIgcXkGJ/yqQVag/5LNYhEMvCuc
 I5oMJ9vjUPqsAMtrU8C/hRXYyNntdjD1Hq1ghJjR0daFIACS3vwGAg12vMV6GY6wEBRt
 w7xpCryxUL8Wle2jKFcQ4oKNEODCa1i4oMyHO5iGuW+n/Z38oLqT5FVQpxJYRvnImUlH
 KEShcoVYW7ce4gaJ7fgXmX+5PkxXzAxeq+plZj/kVYD6w0NWjN9xt+kXu2NZsaMjgAuN mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssubnftv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 16:34:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28TEsV3Q002465;
        Thu, 29 Sep 2022 16:33:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtps7p6h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 16:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zvdg6bOTcVoYYfiNRIRxSapksimvunE0Bioy1Ct6A1qUMnXmUQKCYoBzWS85qYGn6OlDN2TE431HZQUSZaAhlkYfeSWUBh5sWeZIE83PSJLQpU1/UKcVm7WoH1Bny2mOgZinj/PcoZXlerIauz/YlvV1sXik/lDckhquEdDE0WIQt1kDTH3VCyp0umuvvZ8UJAV9GH0f4ARlbLUCwPDBGojzV5u06icfjKnUSOI1pfLnq+7gLEpJRuHIb6U95Wr2g0SLGi6e28LL+yA5M1jIkr0kY3cgQnP+YYrBnLiHH9W+di3Ri6GSXx8H75kTx/8kC7LdZpp85Hftodm8ItIKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//x5Awz9xmLjLxbpRc1Q9OeYw5+b9HFxLC3HCE4p+cE=;
 b=KRPzts+l0+JVlcrGoLbekFzVfh9H+ktJGHktI5ApMEm7y7VAKOkSg4hFDx7CeGABLHqMeYgoJAowod83Ch+QoZ1UsF5eEGkOcWk1FRmGBsVtmJRzeBFkwDG52b+8fB6i+08ZkKi4+kFQcix37GJinMwqzEE/JnDJy6txJYCVN2yNbGC6XuU1uiELJKJjm1U++86bhUlGhZ+M8RC04pm1aV5r+jo8SzpUvbByZgBIB8PhR3y0uW7Pf03y7EMOsF+gCyAUHo+XVQcSTGeFa/3PfsE2hl0yi/pkt8oQb2MYuxGrts4JDCnxNSCOqym+lrWIPidStTmRkVKXbHtQ2BNJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//x5Awz9xmLjLxbpRc1Q9OeYw5+b9HFxLC3HCE4p+cE=;
 b=tlLA3bRQXE57LfQ1gAHVs74v+9QXzGEdtsAPOCwZG9EwFTjOMfltH1mxL9VEQgfC2CZD6NZgjXRetMLv/5JxEGLbgXLqnTol9LhQdJU71x7PRABT4oVFBLs0ZyJ8HHx6gXGk1Sxo5d9sImV3OQ7jUfoIa1Ro5aWcWX6cHIkM5iQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5369.namprd10.prod.outlook.com (2603:10b6:610:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 16:33:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 16:33:57 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Aram Akhavan <aram@nubmail.ca>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Why does nfs-client.target include rpc.svcgssd?
Thread-Topic: Why does nfs-client.target include rpc.svcgssd?
Thread-Index: AQHY0q7LdmAJrj2LI02IlQESddXsYq32nPaA
Date:   Thu, 29 Sep 2022 16:33:37 +0000
Message-ID: <3F31CA77-623F-4A37-85D5-DA955022F808@oracle.com>
References: <589498d2-6cac-47bd-8e93-8fdd44e4be45@nubmail.ca>
In-Reply-To: <589498d2-6cac-47bd-8e93-8fdd44e4be45@nubmail.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5369:EE_
x-ms-office365-filtering-correlation-id: ad5e6268-a8fa-4d8b-37a2-08daa2385c6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k6Ak8I8FJTpLknqoQCsIru97GrvoreCYeCTpWClPStl3A8NZ5p8FI/yRBOlxkq5C5UZ4CoIrOw81r4zFfgWi21XuViV6zRq8Cqbc9Yjp5s+YHwRCgfz7+XxPnAlwXLcj3IRrQH3BT3tvqDl7Gi5bgvTeoZ6xZuVbTEPJOmA2IJEUCOzW2uoEeOchTdLm0HBDO4e3rOIlhK/EsU072Tl1HP/I37HF2Moow/K143Max9CUvYQvQKomZBPMGXO7Q91XJ/kKF2zAktODkvorucSRVLs3ENAdaNoar7+4AYzKPI+NKOujUprJ7fg4WfdvJ8OeLUy2TbTar/5lJz3dMOcR3vNAJa9BN2VAgcguvJ1+iCthxvEWh3lPN3laZP2IW0zVGo8rZTQRaF71aIhuM2rDHOj6KRmRtdvdJVpFlcJKvEn/0Hzt4jSIwLAK7KVcY4FCHoqnq5EZ9dq1qHB8/3Ifdzlwq2OU1vdy5Owq2Vxt8woK06dvuZOt+JzTbDQlhwXsruH+Jr/t88EUmIL71XHdINkWUjQBhDFX344BuH9j0GY/WHS3+3rLP+8oQISgsY9Q4cT74tuJ4qk6FEi/M9/rUXuKznNgqxlRQ5sGWAXYVpAZpUXdCoyz7otX4IWgxMb/e0Ru46imR9RNktU5BBHBfWJnGRajcYCvBqRyZtxpbq109B0pLCuCwGJo4/bMDv4AuyFz3Lib6YWGDeA9GFoI2m+nHifYm8FeHkBLy214ZwjYuKgDJW9cbi1nzKCxwLcbiZ0TN9lUKJvKAZGDyNqq5e57i0NkxpfqV4xa1+vUiKfIdpV6f4xaEjHkOZGMRyKiGewcZ25U8yx/ORpNstPeY2e4TQyg4u2CEcdAlyXZLEU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(38070700005)(8676002)(4326008)(64756008)(66946007)(66446008)(66556008)(66476007)(86362001)(41300700001)(6666004)(76116006)(83380400001)(186003)(33656002)(2616005)(91956017)(122000001)(38100700002)(5660300002)(26005)(36756003)(53546011)(6506007)(8936002)(2906002)(6512007)(478600001)(71200400001)(6916009)(6486002)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mc6IctSlMvsdlWo42IuNgLxHjuNcIItW+CeiVuapyYTisDeRHJ8eD5VOKFCj?=
 =?us-ascii?Q?+e1aV+d3MBvKwRrhGqpE1k0odF85ov40o0P3fuoKBxSTaPfDwDNGs6aIRW8K?=
 =?us-ascii?Q?lrS+tQRiWWCTcFQ2b28U9bvAYJ8TXp6od0bpzCad4ut/dJv9Uhzlb33QL6U/?=
 =?us-ascii?Q?AIsd4qav7dNoEcPmjUEN5v1dI15bBW4/aNWW79sJRdwo0XNOBEQnCR4Wkvdu?=
 =?us-ascii?Q?KTb48wkKkZg+tHdr739O2GBnia1BL0ox5UUSSrTEtP6K1BPIrJumgrFfvqi1?=
 =?us-ascii?Q?keRYPj9smty7UOpx0HoPpsQBipA1OBqQvMVwUP+BB1gOeSEIPawjSaVwNhTA?=
 =?us-ascii?Q?mRYQ8F6s5CK4qugc3lu76QoxzftCeZYmxFZEO39kuuCrDE3kc8ffcZlmHK0Z?=
 =?us-ascii?Q?YpJzYr2CFUMK6xc4xP+K0xiEcv+Scd5FYqxE0nvKOqYP6MXsw6S31mZagsl4?=
 =?us-ascii?Q?t+LNqsa+c1LZN2UJjtF9LT4laaRV5NBiBzLxrtDYTFm8IYKlpOGravMqo99b?=
 =?us-ascii?Q?cds4yvY0xTmMj2W0Sc6qLvJVKOrHYZOCjK32iDDm2nuBJH1jUZXBDxQK8QA0?=
 =?us-ascii?Q?hs6lnOiyhLL20tvyYmiK8AT6Vsf0vwlBkS6aL9Z6f7+05g4h5senQbSSIqXj?=
 =?us-ascii?Q?mxiFH2IrxXQsBvWkfmx5arP522J9RqKKtaFN13TYO7OlBbsyVSBT/NTxRG4E?=
 =?us-ascii?Q?NaD/po0t5oXoJPUszYm6MwOtYQhJjN7DDQ9OKyQcEhFc+1DxANX4qW/HksNx?=
 =?us-ascii?Q?s0PIR6Jtypvs7WC84Cp1DdB6YRjpEnKgc8JYdNSx/XjcuWxnapxOrw333v/4?=
 =?us-ascii?Q?RVcZdoFKxw+oTiZeMfaazaUpIRogVbI9JywxPuvdLJKzwgarZQ831L2MDkW/?=
 =?us-ascii?Q?OCJK48EyZm/rzymvbwF7SxtDHua6SoZJ+02cFKXuTC/x/NpnC/ojSmwO2SFQ?=
 =?us-ascii?Q?jxPlh/ggHfSXF0REo+xrU8vmddeFx88+dyjqeWGgWP3XevDZga010eaTClaX?=
 =?us-ascii?Q?/us94yiEghmWxpNxxCdolFCTpCsB/c9J1ONW1anjKdeOeze9AyHEeOaRKzxW?=
 =?us-ascii?Q?UVaGTnf3uejFIaHhH7zNVp4d2EubYss05sSZ6PZ3+iCT+9XvzgW3kSiZN/QZ?=
 =?us-ascii?Q?nLJsbfkF5+zcbcXgDFyOy1/JRb9wFBe081PwHJLUw/UQx1kIZRgOSFBgpzBu?=
 =?us-ascii?Q?lDLrzdUYaShBumre3PcxY3A5OfAGdmDJ/a7i7nyCB28u8xGcmY7aojeiSrWd?=
 =?us-ascii?Q?flqeXp6eaw/sHi3WHHlJoVKqJZO5YPAbzfqifwJtJvVBOWhIISZ4oew40ay1?=
 =?us-ascii?Q?aAHY9icka99/I5noE7elHnZ5hraF7tkCTJL5vN4MtBqQLQATrBkpVPyZoKHE?=
 =?us-ascii?Q?vfq8EIOMPbZs8JlngOjBK0lTtEJF3KwM3t6f74oc7JrIGV58SHTSia9DV0Ou?=
 =?us-ascii?Q?eHMr83xQws1SojBYUfJzM/es9u8jIBIr2N+SCkH3GfUmL3+PCbRm5sKPxn9J?=
 =?us-ascii?Q?RLrcDre1uUj885gDGyPit3dHvQrM9gCxmdy22LC0qc1/ubQ1WhviroxA2yEt?=
 =?us-ascii?Q?OpkCaEtVGCrPvVg1bLzRvPTh/Zsq9n/Gi+O0hgdic1+eD4OYeAE4PnqXyUK4?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8F4BC30F698C34C8F238E6211C2E1BC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5e6268-a8fa-4d8b-37a2-08daa2385c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 16:33:37.8498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8l8LO6ypIktDVX7RIELYYt93olyvGUAlwHgCLzIBsEcEVfM2Ojj2BdItVZxhzkgiImMw606zwWrtjK8tun6ATA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209290104
X-Proofpoint-GUID: q_aCsfZt5mT61_4svNnFeRz5q_bvYNBR
X-Proofpoint-ORIG-GUID: q_aCsfZt5mT61_4svNnFeRz5q_bvYNBR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 27, 2022, at 4:21 PM, Aram Akhavan <aram@nubmail.ca> wrote:
>=20
> Hi all,
>=20
> I'm a newbie starting to play around with kerberized nfs on Debian. I not=
iced that in the systemd target file nfs-client.target <http://git.linux-nf=
s.org/?p=3Dsteved/nfs-utils.git;a=3Dblob;f=3Dsystemd/nfs-client.target;h=3D=
8a8300a1dfc6e6a77dfe0abed9942ded8f6b0103;hb=3Drefs/heads/master> has *rpc-s=
vcgssd* among its list of dependencies. From the man pages <https://linux.d=
ie.net/man/8/rpc.svcgssd>, it seems this is a server-side daemon, not clien=
t-, and as expected I don't seem to need it for the clients to mount anythi=
ng successfully. Why is this part of the client target?
>=20
> I thought it may be a dependency for something else, but I haven't been a=
ble to find what. Similarly, why is it installed with the *nfs-common* pack=
age instead of *nfs-kernel-server* if it's not needed?
>=20
> This came up because I kept seeing errors on boot caused by rpc.svcgssd l=
ooking for nfs//FQDN/@/REALM /in the keytab, but it doesn't exist. rpc.gssd=
, on the other hand, was updated <https://linux.die.net/man/8/rpc.gssd> to =
search for other principals, like host/FQDN@REALM, which is what gets set u=
p in the keytab by default.

An NFSv4 client has a small NFS server in it that handles callback operatio=
ns.
For NFSv4.0, this server can support the use of GSS/Kerberos on the backcha=
nnel
connection.

I thought gssproxy made svcgssd obsolete, but I'm probably misinformed.

--
Chuck Lever




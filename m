Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D17D794340
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 20:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbjIFSn4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Sep 2023 14:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjIFSnx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Sep 2023 14:43:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65C7D7
        for <linux-nfs@vger.kernel.org>; Wed,  6 Sep 2023 11:43:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386Hde4Y002237;
        Wed, 6 Sep 2023 18:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Jp4Nn0PK4Sze8qjMsbtaK1g1LqQomC3OKyOSgHtKmLw=;
 b=kmPJDdv3SoTXQf2xsmnj4Q7JdJF5dMapxQWKmSEVzd00SWUym/dcW8ApB5CFq8cyesdE
 JddKXYFdItSOO5mCCvfVi04aqW3rscX2qO1rW3mDaxA1QD+yprMhcLyDjAhjDW2UGIaD
 2WG8RHXq8UXwyTprGZkFdItc1DMXASjVDKETMZE4Hh09OsOh8bMjOYoax+cSO1ybaS9t
 u80Y01UWe8bxguIiKaHddBViWT4RFaLTTa78hcWkNSZ4Frr6ksGnJKm8Ss/Fpn0BGfn3
 /Z3JcGLKTVBNBSTZE0MaR9s/YbQ+3H9K6VmLZ/0lUnnjuZq2XYRfLpc/gZfoNhlow6Tp Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxx1085fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 18:43:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386HiJdh007727;
        Wed, 6 Sep 2023 18:43:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug6pqsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 18:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKsXUx0v0ug2Z3wm06T23W5ClpTOZoElYYA9ZLVvQE2TPPVTviFjxibS0YVs2JdjpYtuVQE+9Q5HMfm1k3rPOXTiQLAHRe1p+d7w/uurMghjlASmeXwTmpiiT6oSLNOG9+h8R1LbXdqhCDpr7BKtV1sUn6PYElSX41vD7CyF/hHHhlmdMfW/+WTPNqtEnsiTJFqfpJbjvEj1LXTwpclPJeB953k7D4lA3dcNq3mnxwLSChZEo8ayReXbpkmYpwmnfDXEwXLAF3yxuhNo5sdAan30lc1xZzn9W41V9h7LwsAv7qS145u2asMJO+AEBIEbXYo671BB5J8RR/ZZQvX/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp4Nn0PK4Sze8qjMsbtaK1g1LqQomC3OKyOSgHtKmLw=;
 b=Ngs1X7OZoUgykl9h4G1N2/GH67cNNe7+qalp5TKkPJ5nKUVLYIuWuBTfBXY8ekRzgVfni3ckVDYYhgtFgD0UArI25xaRI6Gh228IQNxsdpjBQVYJLolBNp+lXOJEJnnsWDZ56WhSgCkKYK8+ZSS+oJ6/syLe8+s3RmmhcxcMTnpluOTyWpF8PRqAEXbjobEVpMwoNWJ36769FK+18KQBM5/9Y/IAkVKhtxsjs7DUJ3QKdd+JegFIMFrih7GUgvc+z7dGSmLd7B5rN33psIA+lDQcuGZo/9Ru9gQMle+GH3JPzREWWG4HSMRAGkvByATUEIjQgGUP9i9rMRrvy9SUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp4Nn0PK4Sze8qjMsbtaK1g1LqQomC3OKyOSgHtKmLw=;
 b=kTjKSzSIaJc/AbmUA5Zo/OJwqD1zQV5nTx/lb3DyTT/ykHu4R4nQSR04NBx2pTXhKInOjGWo4e7rNDJW+UA8PgxVVvXE4iU1R+gqg2DdFda9is2LNrN+Sd4lWxIPRp4ydPc+Rci+u6i/YJ2U33qc6KC4UF0ABzyM6hku6xztgsM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4350.namprd10.prod.outlook.com (2603:10b6:208:1da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 18:43:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 18:43:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@kernel.org>
CC:     Anna Schumaker <anna.schumaker@netapp.com>,
        Russell Cattelan <cattelan@thebarn.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
Thread-Topic: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
Thread-Index: AQHZ4F7ccnSO24xLIUyt1pMDrzj157ANzr2AgAAOn4CAAA1NgIAAECuAgAAdxICAAAZiAIAABC2A
Date:   Wed, 6 Sep 2023 18:43:05 +0000
Message-ID: <C2CA99F5-0A50-48A5-905F-EF3C54E89505@oracle.com>
References: <20230906010328.54634-1-trondmy@kernel.org>
 <2854B02F-61E7-4AD0-BF7C-0DC132834416@oracle.com>
 <2308819c5942088713ae935a53d323d3d604cd8d.camel@kernel.org>
 <15DC398B-F481-4FD4-8265-603CEE2454B6@oracle.com>
 <453cd9f416164a026e0932778d2bbcaf04dbe572.camel@kernel.org>
 <36A61B31-5D22-480F-979B-82A1B512F555@oracle.com>
 <011062e833b692272e0fbe39119c9d9c82c92c80.camel@kernel.org>
In-Reply-To: <011062e833b692272e0fbe39119c9d9c82c92c80.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4350:EE_
x-ms-office365-filtering-correlation-id: ad7955d5-1bcf-4b18-290a-08dbaf091bbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 86oEMz9eIUdCYA2I3H82vKaf63pWPVbWUQn71jEKXU/yOIsTpmXe9I5MaH4WVIkGsTUKOQw6MwypfX5l4KkqfFs9ZY3oN1/IgqhP+Nh+sxl409keNz68/W0yYSKOqY+7l+BCrOXG7ZHkOjZfimsaqR+AIuolUkiWYGEVLP7lhDG/d4W8O8CKsHPnR4fogxpwlrUcymoSOxpJFPxrRmJqTTHad7qavOAS8MGtcUWGludkH7/9Wr0PVFEdBlre6yVi3qharV33naD/vWWpWJ4zT+YZ4GOI3C7ML3kx8K0xQlklScNg8emSCZgQhwjiwM7x6rNXOs2X2A1XcH1vj5BasGzPcz/a3qLagHhoXDGbMuG4MUOPonC2ErqZepK8G2ZJ2008AAhdKpJMpFEnNq3eKA0y5OFfB1ER4Qh6dEx6OOJzHIbvtcRl5ypvyfgQOeLtmKe6PiCITR+b+rDmFp2GUbvgZweiwivUE4PxeATN75vrjhsRJefoZwE1SHOSuJqiyv0kKE0pOz0zI9H9PadEUjUd+PYj6r5h99AEwmIhZpPkdWKYhNUl0eOn0uQaLDVfCX0GO2UiurwcE8Zth+ulNiyVdCprfYv005NGDSZqTeMPBuCuuj7XxllOrXjZBWuWVtjvqLuihfW89aH7XLtAFM/ai8jGFYr6kvCkaItf+HIlOY0PNXN+n5V4MuVSxwNL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(186009)(451199024)(1800799009)(36756003)(33656002)(316002)(2906002)(41300700001)(86362001)(122000001)(38100700002)(38070700005)(5660300002)(8936002)(4326008)(8676002)(83380400001)(2616005)(26005)(6512007)(6486002)(53546011)(71200400001)(6506007)(478600001)(966005)(66946007)(64756008)(54906003)(66446008)(66556008)(76116006)(6916009)(91956017)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+GdyBVGqaMZLKrVIA2FKEvmo5l5lICjTGXmAt5q8sjPhvUNNhtjDwbGkJHFG?=
 =?us-ascii?Q?eQ+0/wmn82bnGiNI0MO9VoM/01gqSaZYv+gCff/lJRHB4evthgs9kzD8vKNx?=
 =?us-ascii?Q?Bp/LA9yaAdrFXbWBR0IQsydlXujTlQJWWZrUdK7jmKLmc7QntbTeH2H7jrP6?=
 =?us-ascii?Q?JRhZvKVq/FVxY2hwhYEMyRdKdpsrsDHAdfacwto53cn2rycI7a7e4fJFTLl0?=
 =?us-ascii?Q?mlqrfeoBQezjTUdgGepT8z++J8MqiZfMgqTrSlBNOcfrRCaEhcnxBzR7UaqI?=
 =?us-ascii?Q?Ct56rxlqMqTNg4HWgF5SVIZ1qZdCzCQIEMTUBAcRdAxuRXORSp/zaOxcvJ8t?=
 =?us-ascii?Q?gp5UC2relbiCx7Hwt+iNitrKrEdfF2jhegQyfawNmfFT6xN+xVWqy4vzfggP?=
 =?us-ascii?Q?sK9P1OpPI+iuRPf96ffg3Rx1+slZHFByq1awUc/0Hwy1VSunsCJvnveaAsA1?=
 =?us-ascii?Q?dkF12rhFGxXKaqR5w0WEVoiH5aZ1QxP7Ok1wbok+U/7wlHOMko03N70brtMg?=
 =?us-ascii?Q?//jcQGGAqEMcW3zGqsqdSElyJyvP60zHACuxZ14GOcMinabH4Rbura+ZCI5n?=
 =?us-ascii?Q?UkQmCvLXEvTa1+/0qQnRL9CY4zyCbR1dGdwutheEzqw/wJVYvUM+vyVrc7XA?=
 =?us-ascii?Q?D1nkAO4MLihy9WmMuVvftHXpvl1WkiLeE3py5AfwSTEuz6tQ3BVkbotRGy1r?=
 =?us-ascii?Q?afjO7ZtcqvlIpXHxn4JgeBJ25buAa1BvfU40tPBjV6paLF/o1Ha1iXXyGSZC?=
 =?us-ascii?Q?fwouZ4l6QWn4zMkvUUennnNbjcbco9zb4n8xfyZYZ5Oh+bZFdcGfSOnTwpUs?=
 =?us-ascii?Q?M9uKVguAYtbsHr+9Z8GucbsGIgTvJ/z7DIE9ULWNQJuSGYaMiAlneG3xsfhS?=
 =?us-ascii?Q?f2wncNjwqvykKly2gxMbIMUisvPmPj3BweXkskqwLhQd+QhOghN6saAU3Zeo?=
 =?us-ascii?Q?ZuCOj/ec5g+TrH/VqiL45M5u84pOtQbpUgiahA19U33s/s03Qq3Odb+vNgYN?=
 =?us-ascii?Q?Pbg4f1mypDyELORtOR10tY3SR1LF2kfB2DWoN2JQVsFUGAU6KD43roOIN+P8?=
 =?us-ascii?Q?7YyO7urwjK9Lx6pUzmoum3tSFprS2E/91l1C3Iv1EXtUNL0PAIDNGvkS5Pxp?=
 =?us-ascii?Q?mi7q3+87hhCfeJt7xdL6WCBbicZauNXKTAIbobG07/s4vVhUshlp5lCpV9ax?=
 =?us-ascii?Q?gPgV3cydN238QJiWv/CSvB3Q7ZA7q/K7kA3mOZl2Mqfkq86m+uqMTxxo4Zgz?=
 =?us-ascii?Q?sw8nZM/3wMFAcOG/iK2YMV5Q5qGBNvZA4B+5vfE/jfoYjVqhESIad9r26iDN?=
 =?us-ascii?Q?+DkssmR4Xbjb6SJixLRTq8//JSzncwhBxCr42A9jgD4hdDtRaNkCcs5nWtcR?=
 =?us-ascii?Q?cjAedCmW2BmV1pGsqe75aWRmuPC4PDEnAOXtdjFO4PEZBaCImcBEKRZxX6NM?=
 =?us-ascii?Q?vx4l3v4cCzwYgnFvstQeguoIaYDGde+43gtB0WbSIoT/z/NbfyciPolULSec?=
 =?us-ascii?Q?FALCTFpj/RRYb5hJyejmDjh04urmhJtBK7aWMIrfU91IwGGUWg9U/eduvXLG?=
 =?us-ascii?Q?YTblg9UIpWw7/TwhfXGfxuciHx3mT7HF+4SsCZcJONOQF/vkZU22GiWgJvOE?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E41254C21A99BE49A09E68063C68A7E5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4ZMIzESMI2dr+Ft+2U6AGjBAtVMvybkusRETMY4i1cV5GIxIF49HPMbDb1JO/EHBygRJJtLBS/PGEjU07XuvE8rI11RYnorrGP9jlY94IATTGm6V0PVgyfIZJd06hEm7pn8+5TXhRByepIXpSTJTTpmoSBMDbXP7TCPGDDcW9hf9eAifmRQivN5OSxH6dBU+lDwQsmNkpvvQrPDVPhOjjRHVEEP8T29Q8E2zgoHFXmBKaVpt73KJVxZsk5gO6wo3XmGVPM1uQhQE8Qeh+wYXWULMxDYwOJssPGh+155HRdmFpqKQF446u5n2uGYgcQP5D4kNFAl3pgv8UMHeMlLxR4tNQNRL0Ew3wTz45iAf26wPZ6OcUAm3/o72FDYZGUTYK+toqgkfZG/WFQMDGG/X02+lZXcAV+tlrLz2PcI4rOIzlLYTGDwpLiT7rE6Yretb0dFqdayD+dLte+xbkiBCgp1jw+MnYc3wjl1UVndtyolb5JaOFXqa1qd/P27F2zYJyP/vGgB/73/01cJ68z6IWv6Ug/a5xkDKelg0+0jqN2mMi5z87QIHXlUksXSbgf/7ocfI7DWTiUlv1gVxJmUKbQD1Ml0TIuzsJifaG46DTrCy43BoYPck7rsqC6GmnmEfKBu+kjP1056+Y85JcGkznNRLpnDT5tObHXPkMGIip+e302CBw+2JuDI1KZn+q3VtQRiBFpU/4M+RevvWblq7bab15JWyr6CtVPEg4GaaXlMhv+TbTpCfiDVc7ch5ijgSh4GwL5aJPllzKKjK1O8/EdPFxb6uP+Ouk9ywPrnk82eI4YE4T1C8+1E7LDFIYJ77nF4W5ohzPhLU+iTXY6SQOBdkXtw2aiPDOkOJxu8ozjY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7955d5-1bcf-4b18-290a-08dbaf091bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 18:43:05.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCVJaEqxwp6XlY2S0kYvhzC75kCl8G/XVUCKUb7Mle9GYLwOWB/ih5yugDAbLPDzgkURZ1VQ9soejej/XgsIsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060161
X-Proofpoint-GUID: OJwFkYENhuVKJdM-aO1H-siLBft511hP
X-Proofpoint-ORIG-GUID: OJwFkYENhuVKJdM-aO1H-siLBft511hP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 6, 2023, at 2:27 PM, Trond Myklebust <trondmy@kernel.org> wrote:
>=20
> On Wed, 2023-09-06 at 18:05 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Sep 6, 2023, at 12:18 PM, Trond Myklebust <trondmy@kernel.org>
>>> wrote:
>>>=20
>>> On Wed, 2023-09-06 at 15:20 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Sep 6, 2023, at 10:33 AM, Trond Myklebust
>>>>> <trondmy@kernel.org>
>>>>> wrote:
>>>>>=20
>>>>> On Wed, 2023-09-06 at 13:40 +0000, Chuck Lever III wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On Sep 5, 2023, at 9:03 PM, trondmy@kernel.org wrote:
>>>>>>>=20
>>>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>=20
>>>>>>> This reverts commit
>>>>>>> 0701214cd6e66585a999b132eb72ae0489beb724.
>>>>>>>=20
>>>>>>> The premise of this commit was incorrect. There are exactly
>>>>>>> 2
>>>>>>> cases
>>>>>>> where rpcauth_checkverf() will return an error:
>>>>>>>=20
>>>>>>> 1) If there was an XDR decode problem (i.e. garbage data).
>>>>>>> 2) If gss_validate() had a problem verifying the RPCSEC_GSS
>>>>>>> MIC.
>>>>>>=20
>>>>>> There's also the AUTH_TLS probe:
>>>>>>=20
>>>>>> https://www.rfc-editor.org/rfc/rfc9289.html#section-4.1-7
>>>>>>=20
>>>>>> That was the purpose of 0701214cd6e6.
>>>>>>=20
>>>>>> Reverting this commit is likely to cause problems when our
>>>>>> TLS-capable client interacts with a server that knows
>>>>>> nothing of AUTH_TLS.
>>>>>=20
>>>>> The patch completely broke the semantics of the header
>>>>> validation
>>>>> code.
>>>>=20
>>>> If that were truly the case, it's amazing that the client
>>>> has hobbled along for the past 14 months with no-one
>>>> noticing the breakage until now.
>>>>=20
>>>> Seriously, though, treating a bad verifier as garbage args
>>>> is not intuitive. If it's that critical there needs to be
>>>> a comment in the code explaining why.
>>>>=20
>>>=20
>>> It is necessary because of the peculiarities of RPCSEC_GSS and the
>>> session semantics it implements.
>>> See
>>> https://datatracker.ietf.org/doc/html/rfc2203#section-5.3.3.1 and
>>> in particular, the paragraph discussing retransmissions by the
>>> client.
>>=20
>> Retrying is fine.
>>=20
>> But the counter in the client is called "garbage_retries".
>> That's not what is going on the EACCES case, though the
>> behavior is close enough -- it's code re-use (good) without
>> appropriate documentation (bad).
>>=20
>> The decoder treats EIO and EACCES exactly the same way.
>> Again, code reuse (good) without appropriate documentation
>> (bad).
>>=20
>> I tried to address that in my RFC patch by adding a small
>> explanatory comment and by adding an API contract for
>> rpcauth_checkverf().
>>=20
>>=20
>>>>> There is no discussion about whether or not it needs to be
>>>>> reverted.
>>>>=20
>>>> The patch description is wrong, though, to exclude AUTH_TLS.
>>>>=20
>>>> The reverting patch description claims to be an exhaustive
>>>> list of all the cases, but it doesn't mention the AUTH_TLS
>>>> case at all.
>>>>=20
>>>>=20
>>>>> If the TLS code needs special treatment, then a separate patch
>>>>> is
>>>>> needed to fix tls_validate() to return something that can be
>>>>> caught
>>>>> by
>>>>> rpc_decode_header and interpreted differently to the EIO and
>>>>> EACCES
>>>>> error codes currently being returned by RPCSEC_GSS, AUTH_SYS
>>>>> and
>>>>> others.
>>>>=20
>>>> That could have been brought up when 0701214cd6e6 was first
>>>> posted for review. Interesting that the decoder currently
>>>> does not distinguish between EIO and EACCES.
>>>>=20
>>>> Thanks for the suggestion, I'll have a look.
>>>>=20
>>>=20
>>> Now that I look at it, I think your approach to satisfying RFC9289
>>> is
>>> not correct.
>>=20
>> I'm not following what aspect of the implementation is problematic.
>> I'm going to assume you mean the implementation of opportunism.
>>=20
>>=20
>>> Since this is a transport level issue, why should we not just mark
>>> the
>>> xprt for disconnection, and then retry? It is entirely possible
>>> that
>>> some load balancer/floating IP has just moved the connection to
>>> some
>>> node that was not expecting to do TLS.
>>=20
>> Depending on the security policy chosen by the client's
>> administrator,
>> that could either be a security problem or a "don't care" situation.
>>=20
>> If the administrator wants the client to _require_ TLS, then
>> connecting to a load balancer where TLS suddenly becomes unavailable
>> after a reconnect is a hard error. This prevents STRIPTLS attacks.
>> That's good security.
>>=20
>> If the administrator wants to allow operation to continue even if TLS
>> is not available, then the client can recover by not using TLS.
>> That's
>> rather terrible security, but can be desirable to improve backward
>> compatibility.
>>=20
>>=20
>>> The only case where that should
>>> not be assumed is the case where the error happens right at the
>>> very
>>> beginning of the mount, when disconnecting should normally suffice
>>> to
>>> trigger the RPC_TASK_SOFTCONN code anyway.
>>=20
>> If TLS goes away after a reconnect, that's a problem. Whether
>> further operation should stop depends on the administrator's
>> chosen security policy.
>>=20
>> The security policies are NFS-level settings (eg, mount options).
>> RPC just indicates to NFS whether the traffic is protected or not.
>>=20
>> When NFS asks RPC to ensure the communication channel is protected,
>> that means every reconnect is protected. Communication with that
>> security policy cannot happen without protection.
>>=20
>> Trust me, the security community will have it no other way.
>>=20
>> If you need opportunism in this case, then I can add back the
>> "xprtsec=3Dauto" mount option, which you asked me to remove a while
>> back.
>=20
> I don't see how described behaviour would cause the operation to
> proceed without TLS. I'm saying disconnect and then retry TLS
> negotiation, and then eventually fail.

As I said above:=20

>> I'm not following what aspect of the implementation is problematic.

I still don't understand what you want changed. (Not arguing,
just not understanding).

One or the other side will disconnect if the probe fails. My
memory might be failing, but I'm not aware of the client
continuing to use a connection after sending an RPC_AUTH_TLS
probe that fails. Also I'm not aware that RFC 9289 requires
disconnection after a probe failure, though I believe that
the Linux implementation does disconnect.

By "continuing operation" I mean simply that either the client
tries to reconnect with TLS (in the _requires_ case) or the
client reconnects with no probe and no TLS (in the _opportunistic_
case). A TLS failure, after the initial contact with the server,
will not cause a non-probe RPC to terminate.

If we don't disconnect after a probe failure, I can look into
changing that. But I think we already work that way.


--
Chuck Lever



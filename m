Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9894C74EF26
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjGKMkJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 08:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjGKMkD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 08:40:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC670198B
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 05:39:49 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B8AkeJ022897;
        Tue, 11 Jul 2023 12:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pRNvMQoLLAyxFYTIpdRIMROkP9TJH/5gHkpZlSrhPMA=;
 b=zFLBhKZ7WgzA/IbDorqQVjlAYXzrCejwdIAo0a1d5X8q7EV3WU7aW2KJeZQ00T3HlAvz
 kdc14jM0eNH8ArA0DsmFBLVVw+FsidqZ+7kJzz4NzBpPBdAtIB4NcH3YLsNplVpBDf2/
 M12mvHEtuhUuvaMb2L3WSuVByDtQgrf4ylC+hKI2gPHOvEwDWSwpcNo42rXZIPc73VOa
 ykyCUj+G0ceh9K5qK6vtU/hRhy7RyLx+Lw+cygE2AjRh9gZ16qwBVgI/ylysENj6NM/U
 Bgtnc2Y63biyzHCGeD79NaXSXtguAUo6T74siIZ6arzwQNdBUoVEWTqAl4cuagrvtIG+ ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud4tt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 12:39:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BC58X9000530;
        Tue, 11 Jul 2023 12:39:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rqd292609-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 12:39:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA4nBK8Xb0RAStIUcEvcJ8dxgzknoDItY7QNvn47W3+SrbwWbi1IsSRsTWtjfQIGiI5627KgglOn1L3iueaxVXD6pj/qs8NzUrsAVct7Lvxvm323l3aTMaV1sp3TwJo2z4tKqosuBcW9N2CEhHaV9GI/7ZeER2zGlCw+WvSm3p+/FCXweja2/Z+vdMMWZ9KtOuqb8zYb2uLrzPtLzBrq1kCjKCoOQQIq1LWPrE6V49YRAsPoLDAyJk+O88HZBM1zHHQrIngYoAsnlwxx0ERAyZi9TAOf/Qbfs0oOv00GRsbJp9u9mw7OBw3L9ZGAhpGuYts+jB9x7iXgRj+FUH8oag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRNvMQoLLAyxFYTIpdRIMROkP9TJH/5gHkpZlSrhPMA=;
 b=WxzLM/h+sO/+e98Ey7zw743avfY0stNFjC4K5lEZ3zT462xQb/M/g8nx9wrI5fjb4yw9U4mBfCD0nXVE8gImOy5pdlSMbr5K1IAXIy/a89ifd1HBLfMmXVLUiZE3iThTiah6QG19IkBGqDMh/XdsEPPCFgRPb79u5pmNJLfNXnPP+tPbxFYj+u4YV2UKg3+bJW7Hny0uxF+PPFvBEo7pYq/ZXDfZMpXXy/PTxgsZwX/N68TI7JRPOFBqZ2oIfm/9x0RFfK/TYuP6DVKKuoDddhTa/73Vx0BfMpEeJaFJyeiV6DNzeskum1mLmqvjLRK/I/eKHF0ib/t+bB7HkvKU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRNvMQoLLAyxFYTIpdRIMROkP9TJH/5gHkpZlSrhPMA=;
 b=KWCsWMTRDyFfv1HFPzvy9+tWnYjex0IQ7wZCPb95Wul2lvmdzQt51rwJP4fHBj1UD+LOVVGeaiFXD16YMqk+/p1pMSe1DEWNtKf01S4KE3gbqF5BrQE0uGlZBo3jznReNOtwpdVDFOK4WdJMSD5uRGWRzMNqZNJytjg+oE/SJGI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7088.namprd10.prod.outlook.com (2603:10b6:510:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 12:39:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 12:39:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Neil Brown <neilb@suse.de>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 8/9] SUNRPC: Replace sp_threads_all with an xarray
Thread-Topic: [PATCH v3 8/9] SUNRPC: Replace sp_threads_all with an xarray
Thread-Index: AQHZs02RX5BKEn950kOti0uzTOYZhq+zUOoAgABuAACAAAIzAIAAFcyAgACgJoCAAAvMAA==
Date:   Tue, 11 Jul 2023 12:39:39 +0000
Message-ID: <4E83808E-399F-46B7-9EF1-1D2999C801CC@oracle.com>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
 <168900736644.7514.16807799597793601214.stgit@manet.1015granger.net>
 <9de14c8ef8584545ceef2179f0b57f84ef7706fe.camel@kernel.org>
 <0D6735B0-77A8-4710-8EE7-1F8E382A139B@oracle.com>
 <2909e8cfc2cbd218372e78f5e215759722faba51.camel@kernel.org>
 <ZKy9Q1wX/xPx5Mbu@manet.1015granger.net>
 <c0a221115e2bae7910b9e4ab6eacdc745f320b43.camel@kernel.org>
In-Reply-To: <c0a221115e2bae7910b9e4ab6eacdc745f320b43.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB7088:EE_
x-ms-office365-filtering-correlation-id: b13fec5d-5998-4bc7-1728-08db820be45d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NwqbbmMdizUoTFMsWDdUHnY/M4wSx6hu+o2dvFTtxrL1OlaBVG0ZyEx2LBEVTeJvr60mjeW+PK+LU1jvqNrXDTaxLZjpoOvfG50E8yPgemJgpFKOa/P52PUY2FTchPMrLxKUTbhT3nGKFbiM9PKeUoePUcEBAwVaYYDI6JcVhVXBlBA8KVD4/CV3QvgzyFCrxbaq4rk84ZNtxXzPANW+GI3Dg12QvU2cnpJqiYFTP2VIHYMduuKWMHRofT5NtbFvGTxSbvJUUgYtMDAOhPra9slBRPNsssMZjC6sup18nrReF0GcxhT+z0jNcC12VMhdRjO2/GUI3BwmMxdD8GnDe+Vbng1VoxMf9H2cMBpP44KdGzVnK7JdHiYIW6KiXwa/ZIndDxp2aOrXe8ewJtVqhiovwT+INZtNtTgfCBYQbJecr9w+h0yNjy/YT/Mf5um6+ZyxjeiiLxzsIvuRZES2AoaY9Nwk3P+uPMcAUu0d5ojSaYJrJBTGXkGzHvWfX2ASFeFU+yJGFpWYbUo/VD8BpFaof8BNWgfFkjl5YPQRypS9a15yMyHJfPq4k0mHTBzt7pWzDu4oeqwCNrsxlLM/HdTnbxvyy67rj2z48iZEFenFK/Y5rcXq4cS8MxPjxDwMcMgha5mBidq6/zE9Iw5nKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(8936002)(8676002)(6486002)(30864003)(5660300002)(54906003)(41300700001)(71200400001)(2906002)(316002)(66899021)(4326008)(6512007)(6916009)(91956017)(66556008)(66946007)(66476007)(66446008)(76116006)(64756008)(33656002)(478600001)(36756003)(86362001)(38070700005)(38100700002)(186003)(122000001)(2616005)(83380400001)(53546011)(6506007)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jr12MVJEyWSmOCbXmnUVXy8gIPEO7od8WQDB0yixtkG/hD70yfg8zGMZv/QN?=
 =?us-ascii?Q?EDK0h98qs8qaqF54ar2jCBVhtWTxb6hoMVXkF1gxe6Pyl+M7r04sRK7RNLZG?=
 =?us-ascii?Q?BiIalOVbh/g11e01dPYAVcXW4GuNETH5j2W5uTP2+nY4lBL5WvgM5hkEyvwb?=
 =?us-ascii?Q?u5qKOlsKXJxW4nmikLDyJQ7Fxoc9NXyYTUPiPJEDXyzrYw/KAXusQ797+GAa?=
 =?us-ascii?Q?D/sGF/QbGUujJD4ZvRwLP8SLhD64B/eyMKVZap4PDhFXdARU2E76E/gqCp7o?=
 =?us-ascii?Q?0vvGTH7A3KtNOcx0dolgyObDUVTkc1a+B+M38qLVTqyrLkAqLdxrK/MS1DFQ?=
 =?us-ascii?Q?N0SCreWqw9161jI8LDppXehCrnIcgykJiGB6lYBLnHV2+lmG3vnDrwBXdSTb?=
 =?us-ascii?Q?RjqtSztx09bP17LwRi66HwlDciKnGi0DcxmQO6+yR9Bc1wZUP8TLbKMG1kBD?=
 =?us-ascii?Q?sLKZVMAeVeQdKoSNUii4SDIbulVWGt0DPoziMrpE6McOWrdjWzEYopH2YrpQ?=
 =?us-ascii?Q?A212CsRY0W4B9BHjnDdslC4g2XwKokwaznOQ0y0OryHe5kNY2XAFRE5W+c28?=
 =?us-ascii?Q?/QPGW99FJKmaEBDY2GmaqaSqDsLOQeIrDwzdT3KERbQlwnBFi7/6lvYS9ep7?=
 =?us-ascii?Q?u3V9S4aiCp8HOOdixqhYE90Dm5zyrlybeaF+zGEboUZBa1KCXDmO+Sew0CUw?=
 =?us-ascii?Q?uUVYoTCFoVxs5pcE54O/tpw8S0VhBJ1hNrSEjo6FdrdC+2z79Vu+2q6iTAJV?=
 =?us-ascii?Q?I3RTQe0HdmxXFND1HB/KHsvXQpREQ3NLU9MvG73GWFAG5i+7aBQpR060I8Jd?=
 =?us-ascii?Q?UF0qgB3zbWSHqsFnxhwKQrSZppENPf8noFm7JA2zqk1la/Z5bQ90/C2Q6i50?=
 =?us-ascii?Q?aCI74Y6onnO9O0m9x+uWR2/ieXFCGEtCQTYMyg+ml+0Xtu5nJMgp1PxZXyE2?=
 =?us-ascii?Q?YF6tZ5i4vDAgYbJqN/l21s/btFYbIFraAOI2HfWxRMW5W9kRr/vOzIzpXhZV?=
 =?us-ascii?Q?+d1WICpyAfEywuu/NLE7Gk9fv3RYdkvMkKEW8A4aXz57bQeVaePyJddsiktU?=
 =?us-ascii?Q?+1Wf3uNU2CY/Jkq0WJjhkzDALcCm1yMNknYbW4bN43LrBZsO5jxoPiuKwG9V?=
 =?us-ascii?Q?2EL8Dp8vrz64sOyULhWge0eCUwczX4J18PXCg15teibvvpQp1pM5V32oqRPH?=
 =?us-ascii?Q?IGsV0EuacNr/x2G+vZxKtwvoEA7j5ok3le9tWCpXfNp4nVSdaV8+OzN59Pof?=
 =?us-ascii?Q?JtD+RnMEHuCkdEDb/78V9Gp2xIGMgDQI93aKsYgJeocME5dMSC8nllDNRh0b?=
 =?us-ascii?Q?biJ4x+QRY7ADQvingRliwkflI55Fuq98m0QIrzObnL6Bp7Lq3unNrp90qCWV?=
 =?us-ascii?Q?UGlQZczwsMoVqof55DuhPy0WiALzcNnjVCWFXUkB6VO87dRh4g8Ub3SS7W9C?=
 =?us-ascii?Q?c/nSV6i/xbhXvxPfdUSG9Sz6/SsBJ1CVl0jofTq6VVNYNh1DgTyio6J69bjn?=
 =?us-ascii?Q?NXVeh3qr4UDvHWtXFFjVhktVRh8ha9E2UOPH/+YZ9hiN6QwFL4+3bC0mjdOD?=
 =?us-ascii?Q?PO0cwsCuhOaBgsiHArkDhYEOJOE7vsFhHtDlAuaQ2KZpbdqR6uYEkQvhIlkY?=
 =?us-ascii?Q?AA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C34F9472DAF0AF43B650CAA8BD49EE57@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VcNNLIuo+Z1VJttRKDAyF5/t6q4Bwu0iboXsvk4juxAEtybefybG6AakiblTjCKEPyVFjHHqq2RGlDr5FHE/v/k9dUwkt4KWFZXQ8iCH8/ge54mM3Kac6UTsOD6zPIeS9YPygNq9hdVOzXPg9LPMT5nZaiggwix4c7wHU6y1H4PjzFKPuvQqgweaf9OA/qW1ThPAhszbCP7JDdt/ti25JpoaX2Flcrs6KpxVz79snroDRvJShyz2UInTmWjKOdEes23hct0QC8qNk6ecdxq+pkbi82GXd2R27ah7uSsv2GWW2bv+6C6/GerBqTr5zd88nYsYXbQwZCLDK545Aui/GbuLi6OMP/z8Bbxv69gJwHqnTPLwjCEF2Z2MXLSX9KTjUgsNu54ME8AZJU/QRMjBZv0oDZ9f8f3g+zelFHAr8wRPAIc1hUQmyq/qsfPbrAxcE4rqPTUw2luLtSKQeQkS6KDK/sLQYqfswfTo/PsHqslq8wAOESLWP8qe0HPXBD6WLbNV6V+Al2qY2amtaoTsS7g+xaKy+yte3otn6Ev8yjdCEUo+RMHi6dhIEirpeONXpIOin6VIHIWOA/UCwnecmZXpIeabd4yUy6J8Ox8tLZ8gr5TfcpmeKtbk2Hks6m81yMDNmHibHN4ZBOzEfsPYqDk6eyXk+dB4gN+2iezDIdmnDpCoAnAMK7rzoIhveG+udWUNtIpfosthQMJ1aopfNakrgvLrF33sy7Ybt//xMjOr5hPW2HKlRQuFlPgLOVyx6Nuwf+kjUaLi9NIiHaBV6ueNlmEKF0Uz621XNSG/0mVJv87nidFoGZIA/DlpDlnP0CZBdKf6kwzwotIcHM052u+NxE1/kZCv1aiid+qemA4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13fec5d-5998-4bc7-1728-08db820be45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 12:39:39.0240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkxE2DOCMtBzveA2FY0SKIIaPhic/jYQkMrsE0kJ6f6oLUBK6AzIQ7UnEWrUQjajrdyuM0Wru2tl7p163RimhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110114
X-Proofpoint-ORIG-GUID: yFiIL9PyVREatjm9XFumCK3Qrwy2XsZn
X-Proofpoint-GUID: yFiIL9PyVREatjm9XFumCK3Qrwy2XsZn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 11, 2023, at 7:57 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2023-07-10 at 22:24 -0400, Chuck Lever wrote:
>> On Mon, Jul 10, 2023 at 09:06:02PM -0400, Jeff Layton wrote:
>>> On Tue, 2023-07-11 at 00:58 +0000, Chuck Lever III wrote:
>>>>=20
>>>>> On Jul 10, 2023, at 2:24 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>=20
>>>>> On Mon, 2023-07-10 at 12:42 -0400, Chuck Lever wrote:
>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>=20
>>>>>> We want a thread lookup operation that can be done with RCU only,
>>>>>> but also we want to avoid the linked-list walk, which does not scale
>>>>>> well in the number of pool threads.
>>>>>>=20
>>>>>> This patch splits out the use of the sp_lock to protect the set
>>>>>> of threads. Svc thread information is now protected by the xarray's
>>>>>> lock (when making thread count changes) and the RCU read lock (when
>>>>>> only looking up a thread).
>>>>>>=20
>>>>>> Since thread count changes are done only via nfsd filesystem API,
>>>>>> which runs only in process context, we can safely dispense with the
>>>>>> use of a bottom-half-disabled lock.
>>>>>>=20
>>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>> ---
>>>>>> fs/nfsd/nfssvc.c              |    3 +-
>>>>>> include/linux/sunrpc/svc.h    |   11 +++----
>>>>>> include/trace/events/sunrpc.h |   47 ++++++++++++++++++++++++++++-
>>>>>> net/sunrpc/svc.c              |   67 +++++++++++++++++++++++++------=
----------
>>>>>> net/sunrpc/svc_xprt.c         |    2 +
>>>>>> 5 files changed, 94 insertions(+), 36 deletions(-)
>>>>>>=20
>>>>>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>>>>>> index 2154fa63c5f2..d42b2a40c93c 100644
>>>>>> --- a/fs/nfsd/nfssvc.c
>>>>>> +++ b/fs/nfsd/nfssvc.c
>>>>>> @@ -62,8 +62,7 @@ static __be32 nfsd_init_request(struct svc_rqst *,
>>>>>> * If (out side the lock) nn->nfsd_serv is non-NULL, then it must poi=
nt to a
>>>>>> * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0 (un=
less
>>>>>> * nn->keep_active is set).  That number of nfsd threads must
>>>>>> - * exist and each must be listed in ->sp_all_threads in some entry =
of
>>>>>> - * ->sv_pools[].
>>>>>> + * exist and each must be listed in some entry of ->sv_pools[].
>>>>>> *
>>>>>> * Each active thread holds a counted reference on nn->nfsd_serv, as =
does
>>>>>> * the nn->keep_active flag and various transient calls to svc_get().
>>>>>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>>>>>> index 9dd3b16cc4c2..86377506a514 100644
>>>>>> --- a/include/linux/sunrpc/svc.h
>>>>>> +++ b/include/linux/sunrpc/svc.h
>>>>>> @@ -32,10 +32,10 @@
>>>>>> */
>>>>>> struct svc_pool {
>>>>>> unsigned int sp_id;     /* pool id; also node id on NUMA */
>>>>>> - spinlock_t sp_lock; /* protects all fields */
>>>>>> + spinlock_t sp_lock; /* protects sp_sockets */
>>>>>> struct list_head sp_sockets; /* pending sockets */
>>>>>> unsigned int sp_nrthreads; /* # of threads in pool */
>>>>>> - struct list_head sp_all_threads; /* all server threads */
>>>>>> + struct xarray sp_thread_xa;
>>>>>>=20
>>>>>> /* statistics on pool operation */
>>>>>> struct percpu_counter sp_messages_arrived;
>>>>>> @@ -196,7 +196,6 @@ extern u32 svc_max_payload(const struct svc_rqst=
 *rqstp);
>>>>>> * processed.
>>>>>> */
>>>>>> struct svc_rqst {
>>>>>> - struct list_head rq_all; /* all threads list */
>>>>>> struct rcu_head rq_rcu_head; /* for RCU deferred kfree */
>>>>>> struct svc_xprt * rq_xprt; /* transport ptr */
>>>>>>=20
>>>>>> @@ -241,10 +240,10 @@ struct svc_rqst {
>>>>>> #define RQ_SPLICE_OK (4) /* turned off in gss privacy
>>>>>> * to prevent encrypting page
>>>>>> * cache pages */
>>>>>> -#define RQ_VICTIM (5) /* about to be shut down */
>>>>>> -#define RQ_BUSY (6) /* request is busy */
>>>>>> -#define RQ_DATA (7) /* request has data */
>>>>>> +#define RQ_BUSY (5) /* request is busy */
>>>>>> +#define RQ_DATA (6) /* request has data */
>>>>>> unsigned long rq_flags; /* flags field */
>>>>>> + u32 rq_thread_id; /* xarray index */
>>>>>> ktime_t rq_qtime; /* enqueue time */
>>>>>>=20
>>>>>> void * rq_argp; /* decoded arguments */
>>>>>> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/su=
nrpc.h
>>>>>> index 60c8e03268d4..ea43c6059bdb 100644
>>>>>> --- a/include/trace/events/sunrpc.h
>>>>>> +++ b/include/trace/events/sunrpc.h
>>>>>> @@ -1676,7 +1676,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
>>>>>> svc_rqst_flag(USEDEFERRAL) \
>>>>>> svc_rqst_flag(DROPME) \
>>>>>> svc_rqst_flag(SPLICE_OK) \
>>>>>> - svc_rqst_flag(VICTIM) \
>>>>>> svc_rqst_flag(BUSY) \
>>>>>> svc_rqst_flag_end(DATA)
>>>>>>=20
>>>>>> @@ -2118,6 +2117,52 @@ TRACE_EVENT(svc_pool_starved,
>>>>>> )
>>>>>> );
>>>>>>=20
>>>>>> +DECLARE_EVENT_CLASS(svc_thread_lifetime_class,
>>>>>> + TP_PROTO(
>>>>>> + const struct svc_serv *serv,
>>>>>> + const struct svc_pool *pool,
>>>>>> + const struct svc_rqst *rqstp
>>>>>> + ),
>>>>>> +
>>>>>> + TP_ARGS(serv, pool, rqstp),
>>>>>> +
>>>>>> + TP_STRUCT__entry(
>>>>>> + __string(name, serv->sv_name)
>>>>>> + __field(int, pool_id)
>>>>>> + __field(unsigned int, nrthreads)
>>>>>> + __field(unsigned long, pool_flags)
>>>>>> + __field(u32, thread_id)
>>>>>> + __field(const void *, rqstp)
>>>>>> + ),
>>>>>> +
>>>>>> + TP_fast_assign(
>>>>>> + __assign_str(name, serv->sv_name);
>>>>>> + __entry->pool_id =3D pool->sp_id;
>>>>>> + __entry->nrthreads =3D pool->sp_nrthreads;
>>>>>> + __entry->pool_flags =3D pool->sp_flags;
>>>>>> + __entry->thread_id =3D rqstp->rq_thread_id;
>>>>>> + __entry->rqstp =3D rqstp;
>>>>>> + ),
>>>>>> +
>>>>>> + TP_printk("service=3D%s pool=3D%d pool_flags=3D%s nrthreads=3D%u t=
hread_id=3D%u",
>>>>>> + __get_str(name), __entry->pool_id,
>>>>>> + show_svc_pool_flags(__entry->pool_flags),
>>>>>> + __entry->nrthreads, __entry->thread_id
>>>>>> + )
>>>>>> +);
>>>>>> +
>>>>>> +#define DEFINE_SVC_THREAD_LIFETIME_EVENT(name) \
>>>>>> + DEFINE_EVENT(svc_thread_lifetime_class, svc_pool_##name, \
>>>>>> + TP_PROTO( \
>>>>>> + const struct svc_serv *serv, \
>>>>>> + const struct svc_pool *pool, \
>>>>>> + const struct svc_rqst *rqstp \
>>>>>> + ), \
>>>>>> + TP_ARGS(serv, pool, rqstp))
>>>>>> +
>>>>>> +DEFINE_SVC_THREAD_LIFETIME_EVENT(thread_init);
>>>>>> +DEFINE_SVC_THREAD_LIFETIME_EVENT(thread_exit);
>>>>>> +
>>>>>> DECLARE_EVENT_CLASS(svc_xprt_event,
>>>>>> TP_PROTO(
>>>>>> const struct svc_xprt *xprt
>>>>>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>>>>>> index ad29df00b454..109d7f047385 100644
>>>>>> --- a/net/sunrpc/svc.c
>>>>>> +++ b/net/sunrpc/svc.c
>>>>>> @@ -507,8 +507,8 @@ __svc_create(struct svc_program *prog, unsigned =
int bufsize, int npools,
>>>>>>=20
>>>>>> pool->sp_id =3D i;
>>>>>> INIT_LIST_HEAD(&pool->sp_sockets);
>>>>>> - INIT_LIST_HEAD(&pool->sp_all_threads);
>>>>>> spin_lock_init(&pool->sp_lock);
>>>>>> + xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
>>>>>>=20
>>>>>> percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
>>>>>> percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
>>>>>> @@ -596,6 +596,8 @@ svc_destroy(struct kref *ref)
>>>>>> percpu_counter_destroy(&pool->sp_threads_timedout);
>>>>>> percpu_counter_destroy(&pool->sp_threads_starved);
>>>>>> percpu_counter_destroy(&pool->sp_threads_no_work);
>>>>>> +
>>>>>> + xa_destroy(&pool->sp_thread_xa);
>>>>>> }
>>>>>> kfree(serv->sv_pools);
>>>>>> kfree(serv);
>>>>>> @@ -676,7 +678,11 @@ EXPORT_SYMBOL_GPL(svc_rqst_alloc);
>>>>>> static struct svc_rqst *
>>>>>> svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int=
 node)
>>>>>> {
>>>>>> + struct xa_limit limit =3D {
>>>>>> + .max =3D U32_MAX,
>>>>>> + };
>>>>>> struct svc_rqst *rqstp;
>>>>>> + int ret;
>>>>>>=20
>>>>>> rqstp =3D svc_rqst_alloc(serv, pool, node);
>>>>>> if (!rqstp)
>>>>>> @@ -687,11 +693,21 @@ svc_prepare_thread(struct svc_serv *serv, stru=
ct svc_pool *pool, int node)
>>>>>> serv->sv_nrthreads +=3D 1;
>>>>>> spin_unlock_bh(&serv->sv_lock);
>>>>>>=20
>>>>>> - spin_lock_bh(&pool->sp_lock);
>>>>>> + xa_lock(&pool->sp_thread_xa);
>>>>>> + ret =3D __xa_alloc(&pool->sp_thread_xa, &rqstp->rq_thread_id, rqst=
p,
>>>>>> + limit, GFP_KERNEL);
>>>>>> + if (ret) {
>>>>>> + xa_unlock(&pool->sp_thread_xa);
>>>>>> + goto out_free;
>>>>>> + }
>>>>>> pool->sp_nrthreads++;
>>>>>> - list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
>>>>>> - spin_unlock_bh(&pool->sp_lock);
>>>>>> + xa_unlock(&pool->sp_thread_xa);
>>>>>> + trace_svc_pool_thread_init(serv, pool, rqstp);
>>>>>> return rqstp;
>>>>>> +
>>>>>> +out_free:
>>>>>> + svc_rqst_free(rqstp);
>>>>>> + return ERR_PTR(ret);
>>>>>> }
>>>>>>=20
>>>>>> /**
>>>>>> @@ -708,19 +724,17 @@ struct svc_rqst *svc_pool_wake_idle_thread(str=
uct svc_serv *serv,
>>>>>>  struct svc_pool *pool)
>>>>>> {
>>>>>> struct svc_rqst *rqstp;
>>>>>> + unsigned long index;
>>>>>>=20
>>>>>> - rcu_read_lock();
>>>>>=20
>>>>>=20
>>>>> While it does do its own locking, the resulting object that xa_for_ea=
ch
>>>>> returns needs some protection too. Between xa_for_each returning a rq=
stp
>>>>> and calling test_and_set_bit, could the rqstp be freed? I suspect so,
>>>>> and I think you probably need to keep the rcu_read_lock() call above.
>>>>=20
>>>> Should I keep the rcu_read_lock() even with the bitmap/xa_load
>>>> version of svc_pool_wake_idle_thread() in 9/9 ?
>>>>=20
>>>=20
>>> Yeah, I think you have to. We're not doing real locking on the search o=
r
>>> taking references, so nothing else will ensure that the rqstp will stic=
k
>>> around once you've found it. I think you have to hold it until after
>>> wake_up_process (at least).
>>=20
>> I can keep the RCU read lock around the search and xa_load(). But
>> I notice that the code we're replacing releases the RCU read lock
>> before calling wake_up_process(). Not saying that's right, but we
>> haven't had a problem reported.
>>=20
>>=20
>=20
> Understood. Given that we're not sleeping in that section, it's quite
> possible that the RCU callbacks just never have a chance to run before
> we wake the thing up and so you never hit the problem.
>=20
> Still, I think it'd be best to just keep the rcu_read_lock around that
> whole block. It's relatively cheap and safe to take it recursively, and
> that makes it explicit that the found rqst mustn't vanish before the
> wakeup is done.

My point is that since the existing code doesn't hold the
RCU read lock for the wake_up_process() call, either it's
unnecessary or the existing code is broken and needs a
back-portable fix.

Do you think the existing code is broken?


>>>>>> - list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
>>>>>> + xa_for_each(&pool->sp_thread_xa, index, rqstp) {
>>>>>> if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
>>>>>> continue;
>>>>>>=20
>>>>>> - rcu_read_unlock();
>>>>>> WRITE_ONCE(rqstp->rq_qtime, ktime_get());
>>>>>> wake_up_process(rqstp->rq_task);
>>>>>> percpu_counter_inc(&pool->sp_threads_woken);
>>>>>> return rqstp;
>>>>>> }
>>>>>> - rcu_read_unlock();
>>>>>>=20
>>>>>=20
>>>>> I wonder if this can race with svc_pool_victim below? Can we end up
>>>>> waking a thread that's already on its way out of the pool? Maybe this=
 is
>>>>> addressed in your next patch though...
>>>>>=20
>>>>>> trace_svc_pool_starved(serv, pool);
>>>>>> percpu_counter_inc(&pool->sp_threads_starved);
>>>>>> @@ -736,32 +750,33 @@ svc_pool_next(struct svc_serv *serv, struct sv=
c_pool *pool, unsigned int *state)
>>>>>> static struct task_struct *
>>>>>> svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsign=
ed int *state)
>>>>>> {
>>>>>> - unsigned int i;
>>>>>> struct task_struct *task =3D NULL;
>>>>>> + struct svc_rqst *rqstp;
>>>>>> + unsigned int i;
>>>>>>=20
>>>>>> if (pool !=3D NULL) {
>>>>>> - spin_lock_bh(&pool->sp_lock);
>>>>>> + xa_lock(&pool->sp_thread_xa);
>>>>>> + if (!pool->sp_nrthreads)
>>>>>> + goto out;
>>>>>> } else {
>>>>>> for (i =3D 0; i < serv->sv_nrpools; i++) {
>>>>>> pool =3D &serv->sv_pools[--(*state) % serv->sv_nrpools];
>>>>>> - spin_lock_bh(&pool->sp_lock);
>>>>>> - if (!list_empty(&pool->sp_all_threads))
>>>>>> + xa_lock(&pool->sp_thread_xa);
>>>>>> + if (pool->sp_nrthreads)
>>>>>> goto found_pool;
>>>>>> - spin_unlock_bh(&pool->sp_lock);
>>>>>> + xa_unlock(&pool->sp_thread_xa);
>>>>>> }
>>>>>> return NULL;
>>>>>> }
>>>>>>=20
>>>>>> found_pool:
>>>>>> - if (!list_empty(&pool->sp_all_threads)) {
>>>>>> - struct svc_rqst *rqstp;
>>>>>> -
>>>>>> - rqstp =3D list_entry(pool->sp_all_threads.next, struct svc_rqst, r=
q_all);
>>>>>> - set_bit(RQ_VICTIM, &rqstp->rq_flags);
>>>>>> - list_del_rcu(&rqstp->rq_all);
>>>>>> + rqstp =3D xa_load(&pool->sp_thread_xa, pool->sp_nrthreads - 1);
>>>>>> + if (rqstp) {
>>>>>> + __xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
>>>>>> task =3D rqstp->rq_task;
>>>>>> }
>>>>>> - spin_unlock_bh(&pool->sp_lock);
>>>>>> +out:
>>>>>> + xa_unlock(&pool->sp_thread_xa);
>>>>>> return task;
>>>>>> }
>>>>>>=20
>>>>>> @@ -843,9 +858,9 @@ svc_set_num_threads(struct svc_serv *serv, struc=
t svc_pool *pool, int nrservs)
>>>>>> if (pool =3D=3D NULL) {
>>>>>> nrservs -=3D serv->sv_nrthreads;
>>>>>> } else {
>>>>>> - spin_lock_bh(&pool->sp_lock);
>>>>>> + xa_lock(&pool->sp_thread_xa);
>>>>>> nrservs -=3D pool->sp_nrthreads;
>>>>>> - spin_unlock_bh(&pool->sp_lock);
>>>>>> + xa_unlock(&pool->sp_thread_xa);
>>>>>> }
>>>>>>=20
>>>>>> if (nrservs > 0)
>>>>>> @@ -932,11 +947,11 @@ svc_exit_thread(struct svc_rqst *rqstp)
>>>>>> struct svc_serv *serv =3D rqstp->rq_server;
>>>>>> struct svc_pool *pool =3D rqstp->rq_pool;
>>>>>>=20
>>>>>> - spin_lock_bh(&pool->sp_lock);
>>>>>> + xa_lock(&pool->sp_thread_xa);
>>>>>> pool->sp_nrthreads--;
>>>>>> - if (!test_and_set_bit(RQ_VICTIM, &rqstp->rq_flags))
>>>>>> - list_del_rcu(&rqstp->rq_all);
>>>>>> - spin_unlock_bh(&pool->sp_lock);
>>>>>> + __xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
>>>>>> + xa_unlock(&pool->sp_thread_xa);
>>>>>> + trace_svc_pool_thread_exit(serv, pool, rqstp);
>>>>>>=20
>>>>>> spin_lock_bh(&serv->sv_lock);
>>>>>> serv->sv_nrthreads -=3D 1;
>>>>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>>>>> index 6c2a702aa469..db40f771b60a 100644
>>>>>> --- a/net/sunrpc/svc_xprt.c
>>>>>> +++ b/net/sunrpc/svc_xprt.c
>>>>>> @@ -46,7 +46,7 @@ static LIST_HEAD(svc_xprt_class_list);
>>>>>>=20
>>>>>> /* SMP locking strategy:
>>>>>> *
>>>>>> - * svc_pool->sp_lock protects most of the fields of that pool.
>>>>>> + * svc_pool->sp_lock protects sp_sockets.
>>>>>> * svc_serv->sv_lock protects sv_tempsocks, sv_permsocks, sv_tmpcnt.
>>>>>> * when both need to be taken (rare), svc_serv->sv_lock is first.
>>>>>> * The "service mutex" protects svc_serv->sv_nrthread.
>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>> Looks like a nice clean conversion otherwise!
>>>>> --=20
>>>>> Jeff Layton <jlayton@kernel.org>
>>>>=20
>>>> --
>>>> Chuck Lever
>>>>=20
>>>>=20
>>>=20
>>> --=20
>>> Jeff Layton <jlayton@kernel.org>
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



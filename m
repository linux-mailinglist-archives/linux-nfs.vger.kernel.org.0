Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26151573B3A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiGMQ2t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbiGMQ2p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 12:28:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966E36328
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 09:28:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DFmP5W005808
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 16:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1zIq4vEqILwcek1SmQ/N973fDyQY1FKkXSFVgEdHmgw=;
 b=ZdRR4VH49lLRQnwRRngazhmOBLzB9CQlwy+uFNKdPcBcnFHHZSYXBPbyoO0eiRbOn75c
 jhMIxZHZBLkR6j8RaiQQKPbeshqEz+Unxz/Z3ki1fA+Leaf999OF2QncFrd5sAlNVAon
 3Rl1tuZImytsiHGZEAI4uQ39aoMSNpOsxTX9LNFnLm+VciduLiPQUxGm4d21hH+67QBC
 1905kiq8lbYxLUQRuHUneefUUPyAuqZp+K9zdVMACPHXLi5cTrE8BYzyohql3iO4PAZB
 g+nRqL8EIDQrbI/tQeaObLs/7T/LyfpLnK9H7QqTMK7MNNjpbpUw9I8lm+NyhIzt7Moa Ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgt6wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 16:28:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DGAFwQ004339
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 16:28:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7045874q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 16:28:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPA9OCrJMmO1qRrWJzmiGDlMlYPoXNWjywPvZAZ2YZ5hoXfEKdd5rJ5e4vOiCOQTk6cbzVDgcPUCZ5bbjpw0BbXxg9Y8r4o9kjCyjSaAC/fXtOBQGZRkd0LU5O+6ULvSmfU3/xiy82V6dughrMy0PozpR8YkZbivZIsSe+v8budRjUpmUMzdMaQxjADKSEAcX643gN6iXEHDeWjs2jMa2ayHVKtMSzUIiYktzIPLNanuBSYY17SEUO3CTCipDEqQCXBn+GtOlb4tVvRhL6Zk3BRYq6PQUQ6T5w0HmFBO9ICoEgus34anjOdXFjFe5O1LnETfe+XsEPJZPg3uXS+R8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zIq4vEqILwcek1SmQ/N973fDyQY1FKkXSFVgEdHmgw=;
 b=RcoHb/2e214t0zVKKt5R9STTzLT3ISOxlhIOQJwf3IA2SV4V6kikCTaXs0c5TOXqKgDs0Wc//PK2eCR3R8viz4CsxPB2GkrPpeNyaSYD3KUjP/k0qxDHqX262zQS3WbmBiq2kPWQ/qtCOkYFnGBiBc9wqUqQFBsoTrQ9WVnZ2jlJDzJDdG4FQmdZHkT1GbnQiM7b+NRJGIdDK7EzMvWML2SgCI6FwmhPflfIvgiZZ2BJbM+o17CmrKChywF4BAkRCts4q+tSI2CrA7f1Mk3dxr5GbYaa9QwPmERlq5ZhMor+jQvZaFQUyvT3OL5cMGO+cda4g0//jxgDxbxGGenRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zIq4vEqILwcek1SmQ/N973fDyQY1FKkXSFVgEdHmgw=;
 b=fJlTA4ZBKuGK50+ZhwnpBaxlDzdxV46YoXPSM0lsrufK79rqWThQRD2620oDWJOC4q00AuuVf7mDblNsGERyp/YgdMNO5/UzAwnqgpNxSC+pyv0VpM2tLzUBPZGVEoMDQ2bpuoLMdOc5u3YbKo8nYIttnO/KFSouzRjGfvDhjiU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN8PR10MB3507.namprd10.prod.outlook.com (2603:10b6:408:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 16:28:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 16:28:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Brian Cowan <brian.cowan@hcl.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Any way to make the NFS server ALWAYS report its NFS domain name
 when returning an ACL?
Thread-Topic: Any way to make the NFS server ALWAYS report its NFS domain name
 when returning an ACL?
Thread-Index: AdiTCInhEYXITo0+QLKqItlSwqlPKADyrQxAAACXYYA=
Date:   Wed, 13 Jul 2022 16:28:39 +0000
Message-ID: <CC656FC5-BD4D-4E81-A49B-51D8617159B1@oracle.com>
References: <SI2PR04MB58213B077411EC88ECD11124FE829@SI2PR04MB5821.apcprd04.prod.outlook.com>
 <SI2PR04MB5821A7DA694AED727B99DAC5FE899@SI2PR04MB5821.apcprd04.prod.outlook.com>
In-Reply-To: <SI2PR04MB5821A7DA694AED727B99DAC5FE899@SI2PR04MB5821.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bd33209-08d4-49e2-efe6-08da64ecbe86
x-ms-traffictypediagnostic: BN8PR10MB3507:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZqKWtijFNCGzpnk+WAeRFiOgKm9pJ6qSzxPLuxpCdgs2vd2lYRGBHfupJxOHN1qMP2ww5Hdi6wmc0QCaklHtuAC5YbYzktKkkbhr5GpaF6CMg0C4doE6lrnOXKaU03AciiIg1sY1hKlLw5MlHRnH98PtuThPwZtawumYfN7KcvqZo9QAs2A6ALAoWdyJu1CsfDD+mv3oC+o6tLPJ+isBTkjaOpfrSUVk1cGe9Ne0Uco7+oN1EDDZ4fOHwFkHzuahOgByKJqSq3QiEGgS4X87vELOdw5ft1YUi+D39Xgvih3JYXd4gVKopl2Y2Bp2jb/xEYgundIoVTr9pMAnS5toABAyq8vBqyGpkbIT/cBdBHX4AzyBwzCcSCwTaUN9X3c0lBJ9NTsG3UnDc1yfpWWgCu7zp3eZyLEIB0MsMiYEua9ToOChHT/TcG6lASEGQrMj+i4MJGvDt9EHXEnyp7GqAid+adTE9R1cu5PjuOg/iss27yJdon/uuDF4iuLbRpXsuj4LCKJ+z4ExMmJb3murL7A269moHZSFvM1/P3crh1cQNK9KK/kQJbdAWeRPpNlvuIMWED8dDU0SbB82O6yf8YiAXsVwNbfop68kUrsuVJ8Q6S+BvsQu211Fjo0bFdCPOcmb/FSxpsWGXtSx+oW9J+7A3AnFN88+lVIVJI1IxDy1IOWrFdcpJvErDN3e0JQvgf702Xrd6S9P/yiQbyWnqiObP6BwnUa46ONXx1RipyIm784JPt6EC9kUFQoLdoghbSNocLMg9Q7YdlW2Mywykhz3hCxBzf8PyDoEFHGPhkjzMhlSwjWYHQreuP+yHhmt+gNKYMz7/hSTcIWOIzss5Dg/pK8iuoCDap6vmlBAxYjrb7WcM0xrEDfwgn4Ss3gg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(136003)(39860400002)(396003)(53546011)(66446008)(41300700001)(66556008)(6512007)(64756008)(6506007)(66946007)(6486002)(66476007)(26005)(36756003)(5660300002)(316002)(478600001)(76116006)(86362001)(91956017)(71200400001)(122000001)(38100700002)(45080400002)(38070700005)(2616005)(83380400001)(8676002)(8936002)(6862004)(2906002)(33656002)(186003)(4326008)(43043002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2VjOWRaK2g2eDBHZVZEWWx4SXJpK2dhTkdMbjI1R3pIeEFsdjZQOEl1N3Jk?=
 =?utf-8?B?NzdTRVFjSW1lUGxaTElLQXJ2a3RhZlNOSXVoVjE4Z2p4bjNWbkJvekdlZjVU?=
 =?utf-8?B?SmE1WHk3VE00eHYwWkU0cUVCajVEWlVYVDZtbG4wS2FUNDl5blR1TUt2MEFP?=
 =?utf-8?B?N0JudlAzbm04RTVWRGtNY2NjeUo3UGIvYU5kU1dYa2gzRWJNTFZpRStPUCtn?=
 =?utf-8?B?b2pVQS9uWERTc0phblluUFZ0TnQrcmUwZ2RhV3BrNkxGNmlhMjhYOXVmV1N2?=
 =?utf-8?B?QjBqdktENkMrc3NkVWNTQmlzVExmV0FVNy81Y0R0SklFbUJHdG1QZCtVWVZC?=
 =?utf-8?B?WjQ0a3NjTVd1ck9HT3JDaWZlQUJ0ZDExU2xyVCthM0JmNlcwK1VQVnVkNEh5?=
 =?utf-8?B?TzloK2tCNCtMakk3Z2ZMY3g2ZHo4N1ZBUjQ2aFBNemc2TnMyUTJrR1pSM3JP?=
 =?utf-8?B?Uk4rVllkb3psZTVOVDBpL0NzWXNXMW1uWDVocS90YUR1UUk4OCtsQzBHMmZE?=
 =?utf-8?B?aWZRS0U5cFRkNi9scmxWWGF4TzlNOVk3bERFelZoVklwNGhDNlZoajZsTHgw?=
 =?utf-8?B?dGVJNlVCS0g2VU41WXdVcEhEelBiV2I1dVU0blp4K1d6UGROSmZsek1zSU4y?=
 =?utf-8?B?bkdSWmFiWGRTRWFyeDFOeTBjU2h4WmF0bWZIZ21Yd093UTVCZ3BaU0lxUjNO?=
 =?utf-8?B?d2RuOEpOUnhRSEp0aWU0amZWLy9Bd2pTOWxsUFFpaTlWclRpZFFrNDVBV1JS?=
 =?utf-8?B?NHh3TXRiSm5nK0U3aGFyWmxSRGR4QlV5R2VvbFZTSkhPZm5DNXl2bHBmdnRV?=
 =?utf-8?B?YWJzZ0RyLzR0RWFrc1lhQmJZY051b1Y5QzBVWmFJbVNKa2JldHRXbnl0Ynpk?=
 =?utf-8?B?NzBqL01xUi9pRklLcGlRblVzUTUvNWxoWlpZQmkvT0hRY29UeXJqbG84clV2?=
 =?utf-8?B?S1JKanBvY3F1Y3ZLVVV2NHJUTHdmWlA1cWVBbXVGcy9heHNGWm9DcTFFLzB3?=
 =?utf-8?B?d0MxUFRXbEhTaElWQ2VLZ1Z5MUlZaWo5bm5WZ05nTzBFOVpvOEUveFE1eGpB?=
 =?utf-8?B?ZUVaSGNndU1kV2FpaWVVWjJNWFdrMUQwYWxiNWQyZUM2ZS9FeXhoU1RkWnJ5?=
 =?utf-8?B?OTRpZ29JcmNCMDZMSGVlZ2ZyRlpGblIzdmQwc2R5aDdRcjBlYUgrK3c5MlBL?=
 =?utf-8?B?WTdZR2J2NmoyTDJyNjlKRldjQ29HbG1NZ3dxZ3IyKzJsbGxyN0JkL01yb2VY?=
 =?utf-8?B?azJPL0pZTlEvK2hHQW16NEt6ZmhjRXpPUE4rM0NvVGp4b0lrRlg5c2JDNUl4?=
 =?utf-8?B?dUhmY1AyaGVIRDRUVzlBOExQeXVkVlM5b0VFNW9CNmFxWDFYUlk0Vis1Z25X?=
 =?utf-8?B?VHhXOGdtMVNDbjBETW1RSERjOEJ4M2dLRnY3WWptM0ZnS0w0aEszbUgrdkE0?=
 =?utf-8?B?Z0pobDNjTkJpNXhCTkRicmJVV3FsS0hQejZ6ajhzSFZLY3Nxd0Q0bGI3a2tw?=
 =?utf-8?B?dFJUTXJ1VlhHQWhicDV1dnhENGZrMXhadzUxV0pDRlZKOWRuUDZlOUEraS9o?=
 =?utf-8?B?dUduT2k1eWFDZFJSK3orYU9MdjJDY0pYeDJyUEtXamEyQ2d1Vi92Z2dvMkwx?=
 =?utf-8?B?bjRyTkFOVEJ1WDB0bXpFNmFlZGlEcjY4dVR3RmdaNEdsTVdqenVDVjZKaVZZ?=
 =?utf-8?B?Vm1UTnNZT3VhUHFPV1dBNUNBU2FJWTdDMlllQ2lIYU9yUVRpVllKRXlYcG52?=
 =?utf-8?B?OTFTNTVmMHdnR0hVRTN0dEFpcTFTSEl4bmR3dWtnV29YR24zSlovSFptR1ls?=
 =?utf-8?B?RVY5eFR6M0kxUGxtK2JLNDU4clJkNFJoT09JWkJvWlREYlNuL1duODhtaHVI?=
 =?utf-8?B?dzZGRjgzL3ZueGFWTWlaKytrKzBEc2p1dFhVa3J6OHhWUDE1L2dlWVlFd3E2?=
 =?utf-8?B?Z1loRnUyVmhIN0o2YXNjNUFqK3R6RnpvZWVYQndmczlBZ3Q1UUhCZWZkR01R?=
 =?utf-8?B?NkE0Y2dTVXFSL050MzMrZm9qaG01WFMvUXN5SWd3dTBXS3JnMzRLZ2JCOVd4?=
 =?utf-8?B?TWhXVmt1cng5eUhxSmp2WTlvaGxsbkF1Q25QczhvaE10emsxaTdkMEZKSWp3?=
 =?utf-8?B?dnJMeGFHRlFYZXVtOW14QW5pRWgwSzFvalpwVnNFU0NTdEUra0toUzI2RXJi?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0147D87D62F5BE46B00E3D20940E8F56@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd33209-08d4-49e2-efe6-08da64ecbe86
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 16:28:39.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qp1TonGH0Xu79UsYbwao8lrJ15kuTmszLfs4lVPLnJdYKtmGFvjxlUu4bYrrYmm2ZSTrRn8GDCFfRDDnwWCXwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3507
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_05:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130067
X-Proofpoint-GUID: SH7jOd-ORgySS_ez9IEODV8xVlrrHiuR
X-Proofpoint-ORIG-GUID: SH7jOd-ORgySS_ez9IEODV8xVlrrHiuR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo+IE9uIEp1bCAxMywgMjAyMiwgYXQgMTI6MjUgUE0sIEJyaWFuIENvd2FuIDxicmlhbi5jb3dh
bkBoY2wuY29tPiB3cm90ZToNCj4gDQo+IFBsZWFzZSBmb3JnaXZlIG15IHJlcGx5aW5nIHRvIG15
c2VsZiwgYnV0IC0tIGFmdGVyIGEgcmF0aGVyIHVuZm9ydHVuYXRlIGxvc3Mgb2YgdGhlIFNTRCBt
eSB0ZXN0IFZNJ3Mgd2VyZSBvbiAtLSBJJ20gcmVjcmVhdGluZyBteSB0ZXN0IGVudmlyb25tZW50
cy4uLiAqKkFuZCB0aGUgbmZzIEFDRSdzIGFyZSBjb21pbmcgYWNyb3NzIGFzICJ1c2VyL2F0L2Rv
bWFpbiIgaW5zdGVhZCBvZiBqdXN0ICJ1c2VyLiIqKiAoIi9hdC8iIHVzZWQgYmVjYXVzZSBPdXRs
b29rIGluc2lzdHMgb24gdHJ5aW5nIHRvIHR1cm4gaXQgaW50byBhICJtYWlsdG8iIGxpbmsgZXZl
biBpbiAicGxhaW4gdGV4dCIgbWVzc2FnZXMuKQ0KPiANCj4gVW5mb3J0dW5hdGVseSBpdCdzIHBo
eXNpY2FsbHkgaW1wb3NzaWJsZSB0byBnZXQgdG8gdGhlIGRhdGEgb24gdGhlIG9sZCBTU0QsIHNv
IEkgY2FuJ3QgY29tcGFyZSB0aGUgc2V0dGluZ3MgdG8gc2VlIHdoYXQgSSBkaWQgZGlmZmVyZW50
bHkgb3Igd3JvbmcuIEkga25vdyBJJ20gbm90IHRoZSBvbmx5IHBlcnNvbi9vcmdhbml6YXRpb24g
dGhhdCBoYXMgdGhpcyBoYXBwZW4sIGJlY2F1c2UgSSBoYXZlIGEgcmF0aGVyLWxhcmdlIChhcyBp
biAic3RyYXRlZ2ljYWxseSBpbXBvcnRhbnQgdG8gY29tcGFueSIpIGNsaWVudCB3aG8gaGl0IHRo
ZSBpc3N1ZSBhcyBJIHdhcyBleHBlcmltZW50aW5nIHdpdGggdGhpcyB0byByZXByb2R1Y2UgYSAq
ZGlmZmVyZW50KiBpc3N1ZS4gDQo+IA0KPiBJZiB0aGlzIGlzbid0IHRoZSByaWdodCBsaXN0LCBj
YW4gc29tZW9uZSBwbGVhc2UgcG9pbnQgbWUgdG8gdGhlIHJpZ2h0IG9uZT8gSSBvbmx5IHNlZSB0
aGUgb25lIGxpc3Qgb24gdGhlIG1ham9yZG9tbyBwYWdlLg0KDQpIaSBCcmlhbi0NCg0KVGhpcyBs
aXN0IGlzIGZvciBMaW51eCBrZXJuZWwgY29udHJpYnV0b3JzLiBJdCdzIG5vdCByZWFsbHkgYQ0K
dXNlciBzdXBwb3J0IGtpbmQgb2YgbGlzdC4gU29tZW9uZSBtaWdodCBiZSBhYmxlIHRvIGFuc3dl
ciwgYnV0DQp1c3VhbGx5IGl0IHRha2VzIGEgd2hpbGUuDQoNCklmIHlvdSBuZWVkIGltbWVkaWF0
ZSBoZWxwLCBJIHJlY29tbWVuZCB3b3JraW5nIHdpdGggeW91cg0KZGlzdHJpYnV0b3IuDQoNCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmlhbiBDb3dhbiA8YnJpYW4u
Y293YW5AaGNsLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgSnVseSA4LCAyMDIyIDQ6MzkgUE0NCj4g
VG86IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogQW55IHdheSB0byBtYWtl
IHRoZSBORlMgc2VydmVyIEFMV0FZUyByZXBvcnQgaXRzIE5GUyBkb21haW4gbmFtZSB3aGVuIHJl
dHVybmluZyBhbiBBQ0w/DQo+IA0KPiBbQ0FVVElPTjogVGhpcyBFbWFpbCBpcyBmcm9tIG91dHNp
ZGUgdGhlIE9yZ2FuaXphdGlvbi4gVW5sZXNzIHlvdSB0cnVzdCB0aGUgc2VuZGVyLCBEb27igJl0
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgYXMgaXQgbWF5IGJlIGEgUGhpc2hpbmcg
ZW1haWwsIHdoaWNoIGNhbiBzdGVhbCB5b3VyIEluZm9ybWF0aW9uIGFuZCBjb21wcm9taXNlIHlv
dXIgQ29tcHV0ZXIuXQ0KPiANCj4gSGkgYWxsLCBMb25nIHRpbWUgc2luY2UgSSB3YXNuJ3QgYSBs
dXJrZXIgaGVyZS4uLg0KPiANCj4gQWZ0ZXIgc29tZSBzZXJpb3VzIGdvb2dsZS13aGFja2luZywg
SSBtYW5hZ2VkIHRvIGdldCBhIFJIRUwgOC42IE5GUyBzZXJ2ZXIgdG8gcmV0dXJuIE5GU3Y0IEFD
TCdzIGZvciBmaWxlcyB3aGVyZSB0aGUgZW50cmllcyB3ZXJlIG5hbWVzIGFuZCBub3QgbnVtYmVy
cy4uLiBJdCBmZWVscyBhIGxpdHRsZSBrbHVkZ3kgdG8gbWUgdG8gY3JlYXRlIGEgc2NyaXB0IHRv
IHNldCB0aGUgbmZzZCBvcHRpb25zIGluIC9ldGMvbW9kcHJvYmUuZC4uLiBCdXQgYW55d2F5cy4u
Lg0KPiANCj4gVGhlIGlzc3VlIEknbSBjdXJyZW50bHkgZGVhbGluZyB3aXRoIGlzIHRoYXQgLS0g
YXQgbGVhc3QgZm9yIGhvc3RzIGluIHRoZSBzYW1lICJuZnMgZG9tYWluIiAoc2FtZSBEb21haW4g
aW4gaWRtYXBkLmNvbmYsIGFuZCB1c2luZyB0aGUgc2FtZSBBRCBkb21haW4gdmlhIHNzc2QpIC0t
IG5mczRfZ2V0ZmFjbCByZXBvcnRzIGJhcmUgbmFtZXMgaW4gdGhlIEFDTCBlbnRyaWVzLiBGb3Ig
ZXhhbXBsZToNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gW3ZvYmFkbUB2
di0zMC1yaDg1IH5dJCAgbmZzNF9nZXRmYWNsIC9uZXQvYmMtcmg4Ni1uZnMvZXhwb3J0L25mcy92
b2JzdG9yZS9zaWRkdW1wdGVzdC1yZXAudmJzL3Mvc2RmdC8zYy8xMy8yLTBmNDE4MTdiNjdmYzEx
ZWM4NGUyNTI1NDAwYzkwMjg3LXQ3DQo+ICMgZmlsZTogL25ldC9iYy1yaDg2LW5mcy9leHBvcnQv
bmZzL3ZvYnN0b3JlL3NpZGR1bXB0ZXN0LXJlcC52YnMvcy9zZGZ0LzNjLzEzLzItMGY0MTgxN2I2
N2ZjMTFlYzg0ZTI1MjU0MDBjOTAyODctdDcNCj4gQTo6T1dORVJAOnJ0VGNDeQ0KPiBBOjphLmh1
bWFuLnVzZXI6cnRjeQ0KPiBBOjp2b2JhZG06cnRjeQ0KPiBBOjpHUk9VUEA6cnRjeQ0KPiBBOmc6
Y2N1c2VyczpydGN5DQo+IEE6Zzphc2RmXzA6cnRjeQ0KPiBBOjpFVkVSWU9ORUA6cnRjeQ0KPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gVGhlIHByb2JsZW0gaXMsIHRo
ZSBhcHBsaWNhdGlvbiB0aGF0IGlzIHZlcmlmeWluZyB0aGUgTkZTNCBBQ0wgYWdhaW5zdCBwZXJt
aXNzaW9ucyBzdG9yZWQgaW4gYSBkYXRhYmFzZSAoWWVzLCBpdCdzIHN0aWxsIENsZWFyQ2FzZSwg
YW5kIENsZWFyQ2FzZSBpcyBzdGlsbCBhcm91bmQpIGlzIHdyaXR0ZW4gYXNzdW1pbmcgdGhhdCB0
aGUgYWJvdmUgb3V0cHV0IHJlYWRzIGxpa2UgdGhpczoNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gW3ZvYmFkbUB2di0zMC1yaDg1IH5dJCAgbmZzNF9nZXRmYWNsIC9uZXQv
YmMtcmg4Ni1uZnMvZXhwb3J0L25mcy92b2JzdG9yZS9zaWRkdW1wdGVzdC1yZXAudmJzL3Mvc2Rm
dC8zYy8xMy8yLTBmNDE4MTdiNjdmYzExZWM4NGUyNTI1NDAwYzkwMjg3LXQ3DQo+ICMgZmlsZTog
L25ldC9iYy1yaDg2LW5mcy9leHBvcnQvbmZzL3ZvYnN0b3JlL3NpZGR1bXB0ZXN0LXJlcC52YnMv
cy9zZGZ0LzNjLzEzLzItMGY0MTgxN2I2N2ZjMTFlYzg0ZTI1MjU0MDBjOTAyODctdDcNCj4gQTo6
T1dORVJAOnJ0VGNDeQ0KPiBBOjphLmh1bWFuLnVzZXJAc3d0ZXN0LmxvY2FsOnJ0Y3kNCj4gQTo6
dm9iYWRtQHN3dGVzdC5sb2NhbDpydGN5DQo+IEE6OkdST1VQQDpydGN5DQo+IEE6ZzpjY3VzZXJz
QHN3dGVzdC5sb2NhbDpydGN5DQo+IEE6Zzphc2RmXzBAc3d0ZXN0LmxvY2FsOnJ0Y3kNCj4gQTo6
RVZFUllPTkVAOnJ0Y3kNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+
IEdldHRpbmcgdG8gdGhpcyBwb2ludCB3YXMgc29tZXRoaW5nIG9mIGEgbG9uZyByb2FkIGludm9s
dmluZyBidWlsZGluZyBpbnN0cnVtZW50ZWQgY29kZSB0byB0ZWxsIG1lIHNvbWV0aGluZyBvdGhl
ciB0aGFuICJubywgSSBkb24ndCBsaWtlIHRoZSBBQ0wuLi4iDQo+IA0KPiBUaGUgZmlsZSBpbiBx
dWVzdGlvbiBsb29rcyBsaWtlIHRoaXMgb24gdGhlIE5GUyBzZXJ2ZXI6DQo+IFt0ZXN0dXNlckBi
Yy1yaDg2LW5mcyB+XSQgZ2V0ZmFjbCAvZXhwb3J0L25mcy92b2JzdG9yZS9zaWRkdW1wdGVzdC1y
ZXAudmJzL3Mvc2RmdC8zYy8xMy8yLTBmNDE4MTdiNjdmYzExZWM4NGUyNTI1NDAwYzkwMjg3LXQ3
DQo+IGdldGZhY2w6IFJlbW92aW5nIGxlYWRpbmcgJy8nIGZyb20gYWJzb2x1dGUgcGF0aCBuYW1l
cyAjIGZpbGU6IGV4cG9ydC9uZnMvdm9ic3RvcmUvc2lkZHVtcHRlc3QtcmVwLnZicy9zL3NkZnQv
M2MvMTMvMi0wZjQxODE3YjY3ZmMxMWVjODRlMjUyNTQwMGM5MDI4Ny10Nw0KPiAjIG93bmVyOiB2
b2JhZG0NCj4gIyBncm91cDogYXNkZl8wDQo+IHVzZXI6OnItLQ0KPiB1c2VyOmEuaHVtYW4udXNl
cjpyLS0NCj4gdXNlcjp2b2JhZG06ci0tDQo+IGdyb3VwOjpyLS0NCj4gZ3JvdXA6Y2N1c2Vyczpy
LS0NCj4gZ3JvdXA6YXNkZl8wOnItLQ0KPiBtYXNrOjpyLS0NCj4gb3RoZXI6OnItLQ0KPiANCj4g
SXMgaXQgcG9zc2libGUgdG8gbWFrZSB0aGUgTkZTIHNlcnZlciBob3N0IGFsd2F5cyByZXBvcnQg
dGhlIE5GUyBkb21haW4gbmFtZSBpbiByZXNwb25zZSB0byB0aGlzIHJlcXVlc3Q/IEJlY2F1c2Ug
aWYgdGhlcmUgaXMsIGl0J3MgZWl0aGVyIHdlbGwgaGlkZGVuIG9yIEknbSBoYXZpbmcgbXkgdXN1
YWwgaXNzdWVzIHdpdGggc3R1ZmYgc3RhcmluZyBtZSBpbiB0aGUgZmFjZS4uLg0KPiANCj4gVGhh
bmtzIGluIGFkdmFuY2UNCj4gDQo+IEJyaWFuDQo+IDo6RElTQ0xBSU1FUjo6DQo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQo+IFRoZSBjb250ZW50cyBvZiB0aGlzIGUtbWFpbCBh
bmQgYW55IGF0dGFjaG1lbnQocykgYXJlIGNvbmZpZGVudGlhbCBhbmQgaW50ZW5kZWQgZm9yIHRo
ZSBuYW1lZCByZWNpcGllbnQocykgb25seS4gRS1tYWlsIHRyYW5zbWlzc2lvbiBpcyBub3QgZ3Vh
cmFudGVlZCB0byBiZSBzZWN1cmUgb3IgZXJyb3ItZnJlZSBhcyBpbmZvcm1hdGlvbiBjb3VsZCBi
ZSBpbnRlcmNlcHRlZCwgY29ycnVwdGVkLCBsb3N0LCBkZXN0cm95ZWQsIGFycml2ZSBsYXRlIG9y
IGluY29tcGxldGUsIG9yIG1heSBjb250YWluIHZpcnVzZXMgaW4gdHJhbnNtaXNzaW9uLiBUaGUg
ZSBtYWlsIGFuZCBpdHMgY29udGVudHMgKHdpdGggb3Igd2l0aG91dCByZWZlcnJlZCBlcnJvcnMp
IHNoYWxsIHRoZXJlZm9yZSBub3QgYXR0YWNoIGFueSBsaWFiaWxpdHkgb24gdGhlIG9yaWdpbmF0
b3Igb3IgSENMIG9yIGl0cyBhZmZpbGlhdGVzLiBWaWV3cyBvciBvcGluaW9ucywgaWYgYW55LCBw
cmVzZW50ZWQgaW4gdGhpcyBlbWFpbCBhcmUgc29sZWx5IHRob3NlIG9mIHRoZSBhdXRob3IgYW5k
IG1heSBub3QgbmVjZXNzYXJpbHkgcmVmbGVjdCB0aGUgdmlld3Mgb3Igb3BpbmlvbnMgb2YgSENM
IG9yIGl0cyBhZmZpbGlhdGVzLiBBbnkgZm9ybSBvZiByZXByb2R1Y3Rpb24sIGRpc3NlbWluYXRp
b24sIGNvcHlpbmcsIGRpc2Nsb3N1cmUsIG1vZGlmaWNhdGlvbiwgZGlzdHJpYnV0aW9uIGFuZCAv
IG9yIHB1YmxpY2F0aW9uIG9mIHRoaXMgbWVzc2FnZSB3aXRob3V0IHRoZSBwcmlvciB3cml0dGVu
IGNvbnNlbnQgb2YgYXV0aG9yaXplZCByZXByZXNlbnRhdGl2ZSBvZiBIQ0wgaXMgc3RyaWN0bHkg
cHJvaGliaXRlZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciBwbGVh
c2UgZGVsZXRlIGl0IGFuZCBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseS4gQmVmb3JlIG9w
ZW5pbmcgYW55IGVtYWlsIGFuZC9vciBhdHRhY2htZW50cywgcGxlYXNlIGNoZWNrIHRoZW0gZm9y
IHZpcnVzZXMgYW5kIG90aGVyIGRlZmVjdHMuDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg0K

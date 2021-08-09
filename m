Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B803E47DC
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhHIOot (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 10:44:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51588 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235063AbhHIOoZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 10:44:25 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179Eew8Y016023;
        Mon, 9 Aug 2021 14:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Rnu3SVWaKLePGwWQU6RttmZ3C8nMmuMgBDpKafk5YXQ=;
 b=j9qCBBXvCyKtNguENjHRbzdu6iyaDYLOMnDk8bzKTJT5ktdCfNkTeIMMrtK49cSNeI3O
 LbJegaN/qZ6ehyzOAiOFNVsiKADVFSvMbcy5qJ15GIvFgcfCSZRhE0mwT3QNcZEYNK9A
 efmIJ8Ty73B98hGbI0NYfaMiaNf8/1I40vo59iG4s4TJft8Svc3jd7OeyUWY/QCorXQL
 r8Qv4nRcQ+tXfsyJlJYjhPZvIqz14QRDeW17NfdMVosr3nXVS7v3TTKBXMonPqUqaDE0
 oXvXVXv7AC3IHTjCdJ6g4NR49gcl56H+kLjYicEUAAK5XWcSo4f2nFw5xYEzo38W945y 2w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Rnu3SVWaKLePGwWQU6RttmZ3C8nMmuMgBDpKafk5YXQ=;
 b=aCC1eBbQzBgJGmqqJhOACGN0XbEGr1q1P4eW1y4QPxahQl4mOuHF0IrUA0lTINumCj5D
 V9b5AcxQmdoJDqYZJhp+mdXlFePUaW0ASA6oPjHQFtSTr5L/XUkiLXDXAvNgXKPhAG59
 SdybvqICy0147FvH4s8xZ6nr3qk7qHcZx+oIBaE5EK0QyT1L/kZ1sCAIavig+yPYIJHF
 YR97U9/a3slZEK8EUhDv5ec7KA9BgmFa87XXKHyIOWFgsNAv9xSDfWGChs0sx94HBTOQ
 96kY3tG4e0UUgCwO0vyyc4iSDNaTRBg0Os8cbfZDorDNqzlpRYKO4pdWZm21oWUySN/Y nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aaqmusfqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 14:43:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179Ee7lG123393;
        Mon, 9 Aug 2021 14:43:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3030.oracle.com with ESMTP id 3a9f9v5ees-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 14:43:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea/xXQC8xg2KirRy82LheM9ZGxibdomlfPj2bekgnr0f65C2wkfn3vqv5NURa3TctRA/su0gn+G70dpq8txbdbp19Tm6Gb9f18pdFG33p7DY5UjvT+8KOG77FrIVY5660qcrtr0/Q5HHsrPblXPzFjGDCrxyxOEtb4enUivey3BTLIBXnQphyLo+Wpyyu/eSHT2j6N/62sHjqfshlKHAc43qDeDdz1dL55+FN7dtaaleSQ6c94XxxNxMccfMHR0HHSDCZcnqIrcmHUX3wsDIzX00UV7/fnVrcDi1YEtZ0pFiG5zhhCOVVr6sAXpoyPCWkJGQfPJBHRiV1UjsAbYzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnu3SVWaKLePGwWQU6RttmZ3C8nMmuMgBDpKafk5YXQ=;
 b=gXFMF0PSvRyK8+Vk136itd9S5fSSqBjRKmlItnB3qYUYXzGlCI/bbUACky4xfR9yZC0t43oNwHwjr+pPDD5yuEX3pItLfczchLl4gvHl+k2gmjOZHkxWQBkpQo/bNcvTqF8eN2pMk+mdNtvKm3gyarJ4T75RtfDzJOtdFJ3K+KHCVmu33jyGt9sA5dqR3m+uCKISn6nb+v46jzip+Z49ekxnQkv77vq2FO0z6AFVOSTh+LUkCCNNhy0qEb051osMPuizQae/ucoKI4/xPq24wdvsrsT+ITFB+uY5+37DpXTIj7lW831ovMIsETa2gcwES58zfIsXrh4XnXGL5GUw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rnu3SVWaKLePGwWQU6RttmZ3C8nMmuMgBDpKafk5YXQ=;
 b=f9+se8BG2pi62BX898kPxfcjsZwbj+QP5LbKcdE7ja4bk4YBzqApBDwJ+f3wOFBlHPCs0Q7BJt59J2S3hBIw4h3Q0dIvzR7BuLXDXqf49zUwevDIlnQvr7j9hdwobbas9Lsq17r5XzHdEYiMkmC1VwVDbApwPe5yARDKv1daGto=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3382.namprd10.prod.outlook.com (2603:10b6:a03:156::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 14:43:50 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:43:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Neil Brown <neilb@suse.de>, Bruce Fields <bfields@fieldses.org>,
        "plambri@redhat.com" <plambri@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXhUZ/FEHyhPThcEm96sKxVUAnZKtbmWyAgAao7YCAAAongIAACD8AgAACBICAACJ0AIAAA5YAgAAQJYCAAAG2AIAAB2GAgAACPICACAjvAIAAqEYAgAAF5oA=
Date:   Mon, 9 Aug 2021 14:43:50 +0000
Message-ID: <8C9CAEC7-EAB4-4721-B3F4-164BC9BB6774@oracle.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
 <20210803203051.GA3043@fieldses.org>
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
 <20210803213642.GA4042@fieldses.org>
 <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>
 <162803443497.32159.4120609262211305187@noble.neil.brown.name>
 <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>
 <162803867150.32159.9013174090922030713@noble.neil.brown.name>
 <ea79c8676bea627bb78c57e33199229e3cf27a9c.camel@hammerspace.com>
 <162804062307.32159.5606967736886802956@noble.neil.brown.name>
 <dfe4f6ad0420a67b9ae0f500324ba976d700642c.camel@hammerspace.com>
 <162848282650.22632.1924568027690604292@noble.neil.brown.name>
 <960504100073731731f249c74ac59d933324408d.camel@hammerspace.com>
In-Reply-To: <960504100073731731f249c74ac59d933324408d.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcfee6b2-8462-4f21-9a4e-08d95b441a0f
x-ms-traffictypediagnostic: BYAPR10MB3382:
x-microsoft-antispam-prvs: <BYAPR10MB33823B43201B608BDBD7B1B393F69@BYAPR10MB3382.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w+mFYnAem0uj6N0ZNiN3NdMj7yPp4Rgiboq4NYO81FlfMVhyfltowFThVsOWeRPQ8jUbz8SvClBIqsFDNjzcEd3ria0Z/6YSR3gXVwsg6vORjW5txHm4KaDPi2tPVnE/peBCnnns2fE29xncmqTrk4pEsa1hvNNcxCR/yBcQbSVH6Jo0qkBBCbHCDT/m9Iy8x5eue0hKWKypI+QWQK0xZuKTHtit57Xekr1sRBaq6ZiAjsCAn7Y8SVr3f+tWOTbzUg41qTonv3159TfLsfB3AmAzb5beK96tqMcK0D7efSUuPl/+xNqQqQTWkBfnEFbjHJU0sqmdS8uVIzeStDzaMqdWOyje5hlE0uz6yAP/9rX9n30x3VEgC/7V31Qd+T+fpHC4I+6KF84JAoDtkfkvqBJMdssRy5a7x7ryfeTXDv3qa749aRsDYlurlbbIdDPHVhryTyX/LYuC35sOMMJDbmF0U3H9rYPueB0pNzIzdfRMVjnthlfdTQIUUrYIO1tuoRBGM2SDWtJ+eigmG5qzZUyGBH2ZrnJ0Pd/lvA2dAF/7cktqzvwQh3pFYL/FluALbZ8E3x+Q2dnrhG8B3qxZOnR5D5cbKJr3qwFM7fxZsiPVCZLn/D2VFww4Vzu5I2OdVN50n82e91vW03LDxdShVk35jvTINOQ4jwRaOLMnR9OAjhuU6NcR0FwycYM2PtwjhBI/iASpNDKtRS7SrOTGKxM9aDAdXWJOpTmzbm+EULrLFaOBPK7HYdWMFmMY29cvfCIj1UGYnPanQZSdSTQbqLGFR95Dy6dJUbR+aAsgGvBF9Snhc1pUqvJc9/RLhZPJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(76116006)(6512007)(5660300002)(66446008)(91956017)(64756008)(66556008)(66476007)(4326008)(71200400001)(26005)(186003)(2906002)(83380400001)(38070700005)(4744005)(316002)(508600001)(33656002)(122000001)(38100700002)(6506007)(2616005)(53546011)(6486002)(8676002)(8936002)(6916009)(54906003)(966005)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GregEmTOCPGUFnjMBB4iDkD3/4IMu2Do5YC1411a/BvWBeDvUpRtJVykubcf?=
 =?us-ascii?Q?6m4VhG2Z/kUbhitWn0F/xDy0w5ZXkcm0DMmkjJfGSOdipm6oY3rhKDdXb4Qe?=
 =?us-ascii?Q?HQTbLZJw1otCsf3WBxvMu+8oX8YUlUNnJ5SUbRQbOf7TXGjjEMTmKAAFlvxG?=
 =?us-ascii?Q?59DK3Jz8G7NIz79KombLEQR2MRb4KN7mfb9ohl+Zm3ykwjDzZtxgn+09elIf?=
 =?us-ascii?Q?6aOA9THtceiJ1wh5rDSGyU5K/bIyYO63iPCiXpkwS8OYORh4brN7OJP4BqGq?=
 =?us-ascii?Q?Z5d6Q9xJKYXZt8F3/DQAxPM+bSMSuHwLT0ZjU+2k4nxTdy2ucc+BoUWZSWHT?=
 =?us-ascii?Q?DxYYhhqNDY1E0nt37ZLKTIJc9kbCJmWS1UKKotJ+gNxrHLDbVfm5m8E0861G?=
 =?us-ascii?Q?hetfgEyEb1SvtnLVOjQFL89G2aH3yHSeev5z/XX7TEn+31KDUVl9CnxbeZD5?=
 =?us-ascii?Q?Oem1CzW54V69y0GqbzgsN3DAMlgmBr7QviAcr0jKoh6nPjUUP806mgSeIE29?=
 =?us-ascii?Q?K26FuANqhvz7Z5e9rLqTy1ghTzBMcYqJvUD+eJAJVurwfFXbQsICVT0vt/q8?=
 =?us-ascii?Q?6T8Wpwq1ahhlQmaMpeoesEqITSTJHO07e1bfjVD8RodAxoqFqPCJ9sEsEWUI?=
 =?us-ascii?Q?d9exKBXCjTY4EsUt5gBIsb1rUMK8WCEtXQZISsUeQLDUDhXuegTu2uuG5A4i?=
 =?us-ascii?Q?p1cVkSiV9/SZEKHyCpY9QTvCYWH5XagWCegn5tDcWiwKwxGhwowcNX67Ta13?=
 =?us-ascii?Q?A1OVV6h6wUZqT2DeYqNdj0t9EwrHys1AQ3FuNPvlLL5SQMXuInX/+z77bDFm?=
 =?us-ascii?Q?Ur2gpSFFVbyYbAehaerHW84VWSiJv0FdG+30WrahWYXG5VQhmwja1H1LSbr5?=
 =?us-ascii?Q?w0VpxOC8vdpK5Vnej5kVvtZQC85R5u6JevisgUdZ2dFCfd4arksKsaNvkOkr?=
 =?us-ascii?Q?UenPM4+HNZfRIRmj6IRRNeTUvFqL0mqKoRNoC5J4RYMA99DEQDGo/fuKwD87?=
 =?us-ascii?Q?NU4dwnQr0W3YlXC9PTO3mkGlr2mmnNhWgZTOsaKtk+2ptkmTzUJcIlUKcwui?=
 =?us-ascii?Q?OB3q61WbTxUnoEsRo4f6V6hHjmPyZNuZTPCNplrIPff9/i50NEUcRg5ndyG+?=
 =?us-ascii?Q?0RgHsw2mgbhYBB033DsmdRUdKW6ApP7gcwLSNJCedGYb6oW4HjFncFe8Y46v?=
 =?us-ascii?Q?T/GWAUEwKcZJ/idCkMhsJtnJNS1Lv606v8UAxFQa2VIhoGoqAFn+khHHZ3CR?=
 =?us-ascii?Q?7UAdexz3QOUxoihdION/04TjoN9YATVfUSZrCqDTBXLNVQWIFlOJyOA4LGRN?=
 =?us-ascii?Q?kXywud/IYSnnS2n+Vb6KpovTZWLen+qKOeQmoFEKInEZxA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E44448E53F6A8D4A89F1CCFECD18052C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfee6b2-8462-4f21-9a4e-08d95b441a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 14:43:50.1993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGG3FuyaVhRi/yARnW5Jc6D/bwhpNkVrr5VqytHakgM/RJzxgqabhxOl4y+rzuAkvuA0fBDIJNOvqKoYWCtgkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3382
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090108
X-Proofpoint-GUID: rRUFD0-Ts17KqVVa-Acq3TT6yI5vINh5
X-Proofpoint-ORIG-GUID: rRUFD0-Ts17KqVVa-Acq3TT6yI5vINh5
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 9, 2021, at 10:22 AM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> That's a discussion we can have after Bruce and Chuck implement read
> and write delegations that are always handed out when possible.

I opened an enhancement request:

https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D364

Feel free to add details or correct any naive assumptions.

--
Chuck Lever




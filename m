Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E785709DE
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 20:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiGKSYP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiGKSYO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 14:24:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38F63E75F;
        Mon, 11 Jul 2022 11:24:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BG1EZ1019414;
        Mon, 11 Jul 2022 18:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=p0xFLkLKx8/3LOz7JDElzFkHKj0be/gHodx+D+HbQdM=;
 b=g64RdX5ZEe+VkXgty4RuK6/pnF0tZj5IcbZ/Sy4NBuAP1/12sX8sQoncm31HWFYVuUQW
 qAaF5QTHHWYQrs6h/sbe3gHaE+gvWXKIvhlAU7lbsnHGMGX6TOWF9fQ/r7o8CFgfxd13
 fElqXa7BE90PVOn8dZAOWUhXVzpOHIWCzShKCKN/bfNfCvUYii+iuVlmJWFqt/o79+wU
 BLDXe2ED+roPn9Wme0g3beoeixBLeVMbrVPC+IJkNP8jJ/No6CPwx4HQrVYiTa7dZtbh
 P4MxeeIJu6OhNUDQXq6K5MVLvjijKp0eG4YYfMX2TqIWrhcqDX7FSadSJ2jDVxFKFoUG dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrcbjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 18:24:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BIBXS2036731;
        Mon, 11 Jul 2022 18:24:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7042hh53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 18:24:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAwgZ5EDo6Z8rNvmQDCSOP7SmNCUODZTBD+BOCdH6UcvBSVDuA+W+BlG6IOn2WaIHX75tGT8ScrPsZfgdssjYGjfj4bHUvEiEQW/UTIAdb9kJdwO809+xpJDgVI3wvwYk0wcGKKpoizGK/s6tSkcy3D8RUyFsitjZPDBEwi/CC+pELJgfBmljMOEFu/XZJIyA25iD+54XdG4og8H0YdRKdHsj5lZVFaoZAP/YZQW8uIZDC4t3Ac40HLNj7ZoFENtvsgaZLHT1jiIiz7iN5qkIIvGEz2/YaUfykNdfCKW17GtvBHX46lqwEh2NtU2AE4bCPbUjCsrvdhyrastAgCSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0xFLkLKx8/3LOz7JDElzFkHKj0be/gHodx+D+HbQdM=;
 b=cup3sAtluwe7uCF6ANjvwMtYDj166IaLrnpnuOXEfrcu8Xqx0AvojKxR3QIsMqNdaVtuAPoInMcvIA0Go44Z7XSzpZmHw7wTCLLPf6gPkU9WOvjfik2/AYwr/IC/wuf+uuhi4+NEy3CmX0Kn/B40xSfvdaCceTFPJGsNWm0ZgEJLkudGDhejf857U5q0Pf2P+yjjCzjQ2TNoEUb6CPsYH73KyQU2T2MNNGrxtf6dyjbdzcialghTUXFijVqPu5xn4jqH+ty76o2/C2BHBUTyWjnRnMMofGeZOzpWWT+YmULVdy1KuW4OQ2tiyVAb4YwgPRbb5RMS1rXKBUvVer9H3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0xFLkLKx8/3LOz7JDElzFkHKj0be/gHodx+D+HbQdM=;
 b=ba4XXd6b7+LnFG2Dexy4ZrSzD34B3pguRjtMfdCVZyUZRMxQS0H9dfdCkeMh8E8w/l0IhNnuZ8SnAZEw6Sw3ylpiUIujmpXHhVNntaAsgA6tZz/cBs++ezIgENMtc/Unj+IvpJ7ayKHCQd+lk29S1SeReNO4QhZcMP4IYCFnCOs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1391.namprd10.prod.outlook.com (2603:10b6:300:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 18:24:01 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 18:24:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Jeff Layton <jlayton@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] nfsd changes for 5.18
Thread-Topic: [GIT PULL] nfsd changes for 5.18
Thread-Index: AQHYPS20r3Ca7pclI0+jw5IFRtIPbK14GX4AgABkTACAASsOAIAAgl+AgAABNoA=
Date:   Mon, 11 Jul 2022 18:24:01 +0000
Message-ID: <7CD95BBD-3552-47BD-ACF6-EC51F62787E1@oracle.com>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
 <20220710124344.36dfd857@redhat.com>
 <B62B3A57-A8F7-478B-BBAB-785D0C2EE51C@oracle.com>
 <5268baed1650b4cba32978ad32d14a5ef00539f2.camel@redhat.com>
 <20220711181941.GC14184@fieldses.org>
In-Reply-To: <20220711181941.GC14184@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e292b1f0-b65c-4071-1628-08da636a8775
x-ms-traffictypediagnostic: MWHPR10MB1391:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tn2IcN+A1FBUtmYvKM9EWUtEeb2sOv1Vtm95dqgkh2TcpObMxQtl93M0BIseZWQ1u0eSIguC7DxnsP49CrSKC6me261E0AsJ98rshy1jfpj8+RoC8Co7j4e6fW+cq+iMsI/huPksb4DdN9KH6iA/dxhNmHyxCeRzvWlZXavZTtdZPnNHLJcz+sGlirA9nXFsbOlnfpz+HF9WP1xY6UW07Bi/3YHNKad7mO9wYKNW9OyTle8YQ9qXrU5UQCtt6ICPGU5Z9qcGfks80yqMMUQG/oZqETFfmQ/0CWK6dI8Rjxv+ESrZKI39EdUTbW/L1RdXvI34JHNW1cplm0bW9uauE5x6HXwEGd2chLE2/X4A8YHr1Mekls9bmvpX/romFK8ZUrizKz/hQk5x6Llebs5hvhesnr5UW43rQ5emLjT5b6CWLguKcazgnyZr+FInPMBBAlKDWMOMxLp/HR2DAffJrYgyLsV+JkwZA3yfkAhtNWC+qR73q/XqmQIZI0rUd7MhBU6Dc9yc3Z8UcmH0V+loqIf8Auqv1nAUrJdtURS5hOTFHAcOxKSRyAKsMdnMOTvN+hFirtIynxfw7WQLyK5mGeRKP8+aAzr2ga4Om+ONlRXDfGbwuoAoehLhL1sAdrtppNf+hIJJdzCE9QIhoWenh2aTNz3YSkvRAJ0G2w2PDNAeN96p2yeCrbqCRQLk2cgEIGGfiTF2BtWfcQBdev2vSw5VbIeZRFVEy62UB9BmGLugS7H1JTpHh6BHXCE+d4HOgNgbhasX600nb5jodRIZBzdgu55qubmO9xUwHKnzOzOXabrwq/4Oii4FIS3UwZZ2D8QNGwtO7Jwml8zGcfvZaH9KJ16N8sZUxh0PtaK3scw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(136003)(396003)(376002)(6512007)(122000001)(478600001)(41300700001)(186003)(38070700005)(76116006)(71200400001)(53546011)(26005)(6506007)(83380400001)(6916009)(2616005)(38100700002)(8676002)(66476007)(33656002)(2906002)(5660300002)(8936002)(316002)(36756003)(4326008)(66446008)(86362001)(91956017)(66556008)(64756008)(54906003)(6486002)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NS4GmQbmCJJnbafgEy7Er2BoSHrbfPni09dBm8rE91YjJ1OmUcF0eS+0/o0m?=
 =?us-ascii?Q?9imySzGUrZ4lVI0Ee3Sft3AV8KdSk+M7LNPhymdpHnpA1Cy2tqQqSNLSoDAt?=
 =?us-ascii?Q?E0JZMexA4nsSDtiywfKz00GAQjYNhbSVzZNcCJ4HqOHyDc2PkW6aVrKXn7sW?=
 =?us-ascii?Q?q5KIZZ+cv8WduPScDOeHwjRNwpP1721q7se12ZuyFd1illoYEg0MDIyVCtin?=
 =?us-ascii?Q?ptlpcxKS+B7Xrihz2FUu8+QF1itOHVgMQMOryDhC14/ELk80Bc3O/dVhUieK?=
 =?us-ascii?Q?kqMoNgt/4BDldEn5BdO8bFmDLA9A7kxUsE+sm3XKH368LIHmSIUPd3r5Y6AZ?=
 =?us-ascii?Q?0ZHG/LJX97G4fOHZL7la+qmSv4wHe0b1Lw0OR6fcbvvgsahMgmxkyiS5eFaW?=
 =?us-ascii?Q?RmP8kO/V9IklZX0RZS/nCqYGh6rfQkA/LL1zrSCEYBInjhbTtNukvN00iz8H?=
 =?us-ascii?Q?Cfb55/v6Sl+Sy9L7ShpWGzp5oY7I/DYPC4KCUxoRrp3wDciAi4nlMSzb4SDw?=
 =?us-ascii?Q?f49uv5J31KGdVdPnoB7RdtrKGIo+FZ7VCRIR+gPIdpx4bzqcZPD/Eh4Yvk6J?=
 =?us-ascii?Q?YKGQSetpR9KNH9grboF7h8GzyARzL3XaRnOAKKRg+5jKfO8dEflbmTQV/dif?=
 =?us-ascii?Q?zKdpbAyWSc+9+qnTsIp7tieoeBUCXSJPwXWELraznXTPxaZjpc+5360JGa9Z?=
 =?us-ascii?Q?k+MvlBaKn1plAjAbIhO+aZn5ySATTmGa6+1MJw7ZP0Y8SS8uKmwtcm0shnVd?=
 =?us-ascii?Q?CCHMT/ZyOJngm68Jp9rQzodBeNLI4w2L+5kLhhm/7ZWTQuKuuZiKcUeX1BMj?=
 =?us-ascii?Q?PxJRjAc1QlH+HG+dHD75iBcRVJtV5mU7kKRTROjuRTvTSCiCBzp8+DkfZsRK?=
 =?us-ascii?Q?4yD41YxfBLFb+Pfr1WibIXg21dZ/89mcJ5xE0w6cjmMEoGLEkEigmmcgtRxd?=
 =?us-ascii?Q?DzyaAyNKo1E1HPr8p0Z7RYy1H2PQrHBH+fLj9JvHISsx1TbvKeleb2fi3dbv?=
 =?us-ascii?Q?4y3Wp0IV9ye0uJGZ6K7ruf4lFN5/kXZdwkWp3Jw10Bi0zw7ywM//xoPAytKJ?=
 =?us-ascii?Q?+qruzuelLgEAntVEOJMBduiHafHMunGRnL3NeJdGa6dCdzBULKi8C9TvCZWE?=
 =?us-ascii?Q?k8plB8XjZGnaVSARfborDOBIie0jxnChc5gs1JMmN6tUZ8m9/umLePQzHHi/?=
 =?us-ascii?Q?ByCGAyi5HUfzmYLlqL5yjz2OYDTa/icZsrtE7I6CDipfTrTlL/1g9b1Faji6?=
 =?us-ascii?Q?/pHZdORudmfMhZBjgFoogeaOdZRWDdSf1zKaUFgvKbCzjybQqZOX8aUXdDpt?=
 =?us-ascii?Q?2upgFYX4LaAucDePmUt6k3Z+ZWPp0TmsqMfkfcKMe+aXea788DiTysQM3Wvn?=
 =?us-ascii?Q?I6AYf0I3uUgx2T+j0qRU9rzSWbJJ0WaP6yiwwExjoesBY8HZHgyRIrNDI1iJ?=
 =?us-ascii?Q?uOUFz3QGobKOQ2nJ/t7M2Td7irQoeLrmmY5cy8kBAfuwqllB0NPDx79c4f6y?=
 =?us-ascii?Q?eHlbQgKL40/mrPvcNpkhGpdJFuTm9l3vgWd5fpiy9vN3SNqaHJMWuT5a2FtO?=
 =?us-ascii?Q?+3fmNobrQL5F6hFFmMSxErvZyDImu1D15nP/vZ+srOmC1bCIlAqKKx1VFVh3?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BED49E6698AE514E943C580D305E15CB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e292b1f0-b65c-4071-1628-08da636a8775
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 18:24:01.6314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5TQDTcfk08r4BACfJBSHpIibuayJlVgElprFJUJVcdU4/XpQKapyopxxUO1sOMF7c0ugJ8X+N3jcofxTrmRhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1391
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_23:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110078
X-Proofpoint-GUID: Pr2nTJ9fUdG9yUmKbI3wbxaWUVf0_5eL
X-Proofpoint-ORIG-GUID: Pr2nTJ9fUdG9yUmKbI3wbxaWUVf0_5eL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 11, 2022, at 2:19 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Mon, Jul 11, 2022 at 06:33:04AM -0400, Jeff Layton wrote:
>> On Sun, 2022-07-10 at 16:42 +0000, Chuck Lever III wrote:
>>>> This patch regressed clients that support TIME_CREATE attribute.
>>>> Starting with this patch client might think that server supports
>>>> TIME_CREATE and start sending this attribute in its requests.
>>>=20
>>> Indeed, e377a3e698fb ("nfsd: Add support for the birth time
>>> attribute") does not include a change to nfsd4_decode_fattr4()
>>> that decodes the birth time attribute.
>>>=20
>>> I don't immediately see another storage protocol stack in our
>>> kernel that supports a client setting the birth time, so NFSD
>>> might have to ignore the client-provided value.
>>>=20
>>=20
>> Cephfs allows this. My thinking at the time that I implemented it was
>> that it should be settable for backup purposes, but this was possibly a
>> mistake. On most filesystems, the btime seems to be equivalent to inode
>> creation time and is read-only.
>=20
> So supporting it as read-only seems reasonable.
>=20
> Clearly, failing to decode the setattr attempt isn't the right way to do
> that.  I'm not sure what exactly it should be doing--some kind of
> permission error on any setattr containing TIME_CREATE?

I don't think that will work.

NFSD now asserts FATTR4_WORD1_TIME_CREATE when clients ask for
the mask of attributes it supports. That means the server has
to process GETATTR and SETATTR (and OPEN) operations that
contain FATTR4_WORD1_TIME_CREATE as not an error. The protocol
allows the server to indicate it ignored the time_create value
by clearing the FATTR4_WORD1_TIME_CREATE bit in the attribute
bitmask it returns in the reply.


--
Chuck Lever




Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD3761A81
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jul 2023 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjGYNt5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jul 2023 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjGYNts (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jul 2023 09:49:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F424212D
        for <linux-nfs@vger.kernel.org>; Tue, 25 Jul 2023 06:49:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7oNlW015615;
        Tue, 25 Jul 2023 13:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HWKPvd75ngK7GAki+V6BMCghVjCPLBr5JyjHz4EI3Ow=;
 b=FXALWCUpjj44YKILzZkmkQwbTE5LzJJhlcZX+luj4kP3+wtC6qzuzro8RFuGkudahUsI
 aqpX6r8fsHeo9XJdyWHVNpinx1FVON/cSjljeZM+SC4TSp1NUnwvf3+VMjENM2ozeWPv
 rIjlKB86Rs13wzJsfBjJca9DkmqdyOwHwz2pUG5ghymMeA500XM/qmnOq+alaZBymjpO
 7WfkR7rEqIgsbn15ZTgDJkdh4nz/qXxTOaBwcwSTApC9gSlAL68pBO1VKxw+JNfl5lkS
 kD+buXlDWNml/SE+qKOelWTS7a1Cg8yhYyyA0lcwgiLfULfg0nCfl99SueHBFPQzmMh8 jA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtw2dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 13:49:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PDMi2T033463;
        Tue, 25 Jul 2023 13:49:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jb2krn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 13:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQgS6B/yyWM31ylCXLK9EnlIhBw7fTDfreZKDxP656vVxcY7w1jaDoEE9uo8gQAdZxwytQ7XQs+cV8Hr/gbpuz/yWwg9mnxWvq+iAndBhSaJTaMBRZsw2PrqPpMJnPMKU5cROtJWRHCuWOt/Bi8KkX2y2d7LHSc40WZiCHehHZGh2TZjZH8qySR/mlvFQgSjztZNqXXniDJsQe8qKSRuw+IWZT5P4LKVGhB0/O3ISKl5mEnhvrkF7FgdA5NNnhNCrjh3n46+dJsc5zuZJ3TiL6+iI13wmI3l3Y7BHqFkkKx3s4tS1mJSulneFjT6zBEhnOLHxot3Jgc4F7I4Fj9ulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWKPvd75ngK7GAki+V6BMCghVjCPLBr5JyjHz4EI3Ow=;
 b=ideBYLpi0ILy1op267386EzG8MkBAPHHzys0npURSSsYMxI7LTOt2E8MVMC359D1zF/B9lhdeQYdBVmNbWiWlCfe9QoCnWH0+rtsdoFDJkR0S5G34FMXq5ardpuPfyUNGVRSeKmIAIO0nPP1p1Q7qjQDVBTkPdOzlpM0BbokgNwnfQXSr+5X34IWxOl3fgPoyZzGeUJx8Drq+nhiT85OYiX0klTdDxe9BJFRbuCVm1hQWNDumpKHGK2p60kwlqG4nBgnLRIZB/uTV+7hbLBpUHYuu7pDDVsufa4m62xi/ME8R8mx2aC57dfohs8Be/UtoX8jUDWg/J2Msv+NuR49ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWKPvd75ngK7GAki+V6BMCghVjCPLBr5JyjHz4EI3Ow=;
 b=qYQ8kthRO727zuCVmR85j2Le19YIyVvMhpLlPVvyIr9O2n9dG8vU/YbogWxyJ22Q8HD/2S5fkb6AAWHklmkKgx/XgNW3ASciRLrdsQhAkjVfQi2zEFnTXIYHon6NW3S9SR2vYgYkaxFVUB6J9hW+IkgV9lJxEI/ptNsMGCx22rM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5637.namprd10.prod.outlook.com (2603:10b6:806:208::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 13:49:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 13:49:17 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
Thread-Topic: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
Thread-Index: AQHZuUKpaE3Yn0PdG0Ko1CF5yZZwz6+/jVSAgAC9awCAAMgaAIAAqcoAgAAG4ACAAPceAIAFpfWAgAIqcwA=
Date:   Tue, 25 Jul 2023 13:49:17 +0000
Message-ID: <88B0F411-266F-4176-A4F3-3BD048CF2601@oracle.com>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
 <168966228866.11075.18415964365983945832.stgit@noble.brown>
 <ZLaagzqpB9MsQ5yb@bazille.1015granger.net>
 <168972938409.11078.8409356274248659649@noble.neil.brown.name>
 <9EEE82A6-6D25-4939-A4F5-BAC8E9986FF3@oracle.com>
 <168980881867.11078.6059884952065090216@noble.neil.brown.name>
 <E93923C4-080B-4B43-9A3B-28A233BF5DFC@oracle.com>
 <3A9F5306-EAEE-427C-80D2-E0CD81212238@oracle.com>
 <169017387952.11078.1482563019296445946@noble.neil.brown.name>
In-Reply-To: <169017387952.11078.1482563019296445946@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN4PR10MB5637:EE_
x-ms-office365-filtering-correlation-id: 14852c92-57c8-4512-299a-08db8d15f079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+8oJlNQ/ObTMgxR60GiVtZ3zIMhI9Vo2IvKuAT71AOabtcZTaUPaa5rMKiepnd13l4U+3ULwmoe+bIWhgDBBJJA96BoSwjaAORiT6OKORwDC+w3vz8lQlCgLZOQpnzHHDJdKvKW7DeHrtx3zIFmkZ48GnXSmSAP/40Xfx4LYpIVJkfN/+NguaaWuT+3iG94f4GL9uzBddaxKjx/6fXFiv06p1+rRvPNoUI7WC6iZrvjlTEnoyI+KdXRpLi7WAxsraIyedPgbf2PRCOY0gmFNoPPEH+yhkLjri7WkvpRSbYFiMceoPnT02FILxBB0Dac4cSYQT4IXixRq88TQYxuK/5adYNecGZu3igWeqveVOgHStLGPN1JaSXGCHyTeOh5aAgC4GzcleB4bj45FaFLB0wxcBBkW5JaK+17SZv4iKlc29CH8n1EzfWE7vil6dAzRyrOIGo7zVspjo3I/pnAKz5EOKTFnhbEAacxTsPFDy0y64uXjy85M43/XzVKCBg0FfqKaaHgXF48Fhsg/1UkWoKf39KrIqKsqOO52CFOX+XMseIWOCkPws2LIEChMyFc/sYprMQeO1YWdGjylAa/erlUN3WirLsjD6Pf1Dcva4RJWILuLwoLEQEuE/21Kxf7EEwqu9s+8+EmTWWVAb9iAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(186003)(2616005)(6506007)(53546011)(26005)(83380400001)(478600001)(71200400001)(86362001)(122000001)(54906003)(6486002)(36756003)(33656002)(316002)(41300700001)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(38100700002)(6916009)(4326008)(2906002)(8936002)(8676002)(5660300002)(38070700005)(6512007)(966005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EYbEvcF+Xl/xuTDkFe/fluiI6by9J6gnBJjASizvX9jNYZxq7hHmnvbtIHnF?=
 =?us-ascii?Q?jlX8QG2rMjS9AYmc4uTQw0XOI5JUh18SaEylTTsGLf0EquU61zi4i1x7nG1W?=
 =?us-ascii?Q?XNHQwQE1ueXbc6p5P1eRj10Kh9JYENBV3XrBQ8svVAy+C8cm3SsERIEIS+30?=
 =?us-ascii?Q?UUX1gJrxThj2zy5oNWFflJF1a3DH2Thzs8qRvb3sYJjtX1AGRGG9fWxUv1Nb?=
 =?us-ascii?Q?HrDHD3HRm+Pn02juITYjkj7+WXVa9CW18CB171zlpAVmn9BLMBTL+2yqLUQP?=
 =?us-ascii?Q?+edmRaKfcQRfrFOy/93GOkJQ1i0f/GgpvPtXoaZS4YgwzkAECMkO9RkLRy3F?=
 =?us-ascii?Q?pWe8qIucSn1jQOzz/vfM+nuA2mNyu4qT3JZKZqSvj4pOLLQuk/qklOxaVAVG?=
 =?us-ascii?Q?bmKzLw+n0GPHcgO2k/nzyJwcvX7VFD1DMqsx8V2w4/Vcz7oPxfxJ25A3ZYRx?=
 =?us-ascii?Q?qZhYYKidzQRFpuSCdAcXYxgbAeNH+QHuB4dvs3fgio2PDrB4LKKOvHVgsuCe?=
 =?us-ascii?Q?/kUbIoEcAMK7D1vcY8/v3iGo691eJeoEcimLgsaySrYJKdCVjfKVLa4Ww6zZ?=
 =?us-ascii?Q?gOQJ6C5QF6eJ0kWw7Yso/Iyg2DmUOZfDw6sa7UNjlf0wBSnXeWnO3zmVtIx/?=
 =?us-ascii?Q?yvc8ajG9EifKICk2FUc5yWzsDvt5pQPnP3J+xyHKkMQ695BSfP7u6muV7c9z?=
 =?us-ascii?Q?vZXwkeGGtjfKa/bgp16jid8m//2A6ClBQtOxOlES10kE5gXf+l6T+s78AOPc?=
 =?us-ascii?Q?cqW/7GzNjiV34UV40jF3xO+gHBoZVwvQ7QIXpgMGcbqu4OlCljvIsORybUlX?=
 =?us-ascii?Q?oyPVCOuib5nj6xJuZ9rG6MB+LwKahMdpXsfA1Faguv3GxjxLd1NOpH474xdc?=
 =?us-ascii?Q?V5CApxwfQDE9/tRNlmAGaRtuUrwKNZdGzdrz68J4xdsW6cYyg/NTGfuMSwFv?=
 =?us-ascii?Q?LzSZlElIpOntrl3deTvyE5OEgeaBqRTNbG9xbhbzSp6C/R0j+335gaaU0BtT?=
 =?us-ascii?Q?NUbP0pgWizZEUZ4aDLKBOP5V6eNcI5o2nkDZxbEYElprB2SAxTTj04ggqD7c?=
 =?us-ascii?Q?p1t/Paiju1ChAghtc+jdg9qX9XLEnNi4DLxDOdzO4grqin/3LHe4PE5KW8PK?=
 =?us-ascii?Q?/ZLY4ugjF6cLfoLhr52n+W6E7A1haaNeWrbSOquaI4KUwNRTP+NjNsu6Wbfh?=
 =?us-ascii?Q?muCLQfmDznuRhzI2xkl6ta2VfffQCo9Ol2llSkprJlOU9SMUMCAj81xPOZ8J?=
 =?us-ascii?Q?cMkA69YmWL2Rz8jjh1yPni9Pz/iDk49AGoqOGwIhZu4gjMKMJnzCwADC6epR?=
 =?us-ascii?Q?eFv5nviZXW+FDgwYWYvPgd5ZX5oJg/i+BvHRaKLQq2m88TtlejcoM9SOsBds?=
 =?us-ascii?Q?J+zuvpb045PSwyGB5X/xesyhNDBIkbq0nyZ70mwgiw6tAPNrw5ADqGfTZySs?=
 =?us-ascii?Q?W/kj3lgRSzTWy8p4mIUSmWlTqtSj2JQ7aikEHN2oJ4ifCGZU5lhmceAgeNXa?=
 =?us-ascii?Q?OveSIe2iK2T/yA5T+WVT9BMourmrkrxqU9nCqByV+947OsIdaizhA/77W7tK?=
 =?us-ascii?Q?TtmSsxuJHW3Xe1Zhm5wwae0vjA92scyrwNPYP/dVZNQRTpVuBdvy/JabZg4y?=
 =?us-ascii?Q?2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <439E39EDF6D0FB4C8103E3FC56B9DFDE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MfCGR7mYIs3AaFlR8cb4fHFCKDACcKgUBaU6NEyQ6CTz6ZOvmY2DGrYMaSQAgwMsANq7RQwxgO9aBq6NAYWSUo8zLpIjoaX6l8qPA2cODQU8vwunDY8sdxzv/J5adgkUXpiUNW7ePPXnQRzgOYj6fedHmKvv6RpNA7EdaTdESqUGJemVWpFO68IG9GXHHqj0wor4U6dfLLhk7ZMyhqOw1p6uAgWevKdc6BkxD9tEq+QpAgvpVUbGrccs2vZdcPlw8zouB8uQd/XwV8E6lJ9Inz76uydOa6TcBjL8Y8aki/WJFPh5MuTHcfYYad0V0cTekb1tDvpGZndvm1DMj8bXzIAuWEdA3IaakH5x+DOL4HS45XyNP+3W+bS/++wqEG4HIHxQQAoBnmwqsRI9m36UIP2ew6gTRORTO9bNGN2X5nvRGlT9av9qeKpLW110vh5i2bWf8Flv8mzglWpDlxHtdfGvM3hxH4lrxdwKONbwT40gr72muwRj7sJc43KkdEO7QvaPoQOYIRpy/lwKhPLfPUkT+pgxcHjSF5d7FOLHYuyTmf4mK1vP+sFxcCfTwcmHTsPoYYW+aOIS6Jxm+uKSefHBiqelCmbowkZoH7tTNBk1TYUrU/ydO5awWUkfSqLe8HWXS3jNg3petjVzilhBVGwNBaR2O/oJvLV7tPUB/96hZRBYH4XfuJ8COcwLEjSgiWdJSZOPr0rQ2R2l+NFmP5n5Uw6xYsQofK4zePqFJOEPX6eJsioCFjn3GYauaqmNlnDo4GddpdywLQZjJDp2Y1wxblBKhja42U7b4odFk383Ahh8+HpW0Uk15Y6QJPIE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14852c92-57c8-4512-299a-08db8d15f079
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 13:49:17.1159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxJql/rSnXyj0LT0uzbOCDZWoB69vwL7X2I36GTAuBNleBxBTh7VMG1rZ9EMg43XvkvIw7989EzL4nH2Gow5Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_08,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250122
X-Proofpoint-ORIG-GUID: 1rnwQrQIs7Vl83Hyzha3zUCWuyNvlfo_
X-Proofpoint-GUID: 1rnwQrQIs7Vl83Hyzha3zUCWuyNvlfo_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 24, 2023, at 12:44 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 21 Jul 2023, Chuck Lever III wrote:
>>=20
>>> On Jul 19, 2023, at 7:44 PM, Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>>=20
>>>=20
>>>=20
>>>> On Jul 19, 2023, at 7:20 PM, NeilBrown <neilb@suse.de> wrote:
>>>>=20
>>>> On Wed, 19 Jul 2023, Chuck Lever III wrote:
>>>>>=20
>>>>>> On Jul 18, 2023, at 9:16 PM, NeilBrown <neilb@suse.de> wrote:
>>>>>>=20
>>>>>> On Tue, 18 Jul 2023, Chuck Lever wrote:
>>>>>>> On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
>>>>>>>> No callers of svc_pool_wake_idle_thread() care which thread was wo=
ken -
>>>>>>>> except one that wants to trace the wakeup.  For now we drop that
>>>>>>>> tracepoint.
>>>>>>>=20
>>>>>>> That's an important tracepoint, IMO.
>>>>>>>=20
>>>>>>> It might be better to have svc_pool_wake_idle_thread() return void
>>>>>>> right from it's introduction, and move the tracepoint into that
>>>>>>> function. I can do that and respin if you agree.
>>>>>>=20
>>>>>> Mostly I agree.
>>>>>>=20
>>>>>> It isn't clear to me how you would handle trace_svc_xprt_enqueue(),
>>>>>> as there would be no code that can see both the trigger xprt, and th=
e
>>>>>> woken rqst.
>>>>>>=20
>>>>>> I also wonder if having the trace point when the wake-up is requeste=
d
>>>>>> makes any sense, as there is no guarantee that thread with handle th=
at
>>>>>> xprt.
>>>>>>=20
>>>>>> Maybe the trace point should report when the xprt is dequeued.  i.e.
>>>>>> maybe trace_svc_pool_awoken() should report the pid, and we could ha=
ve
>>>>>> trace_svc_xprt_enqueue() only report the xprt, not the rqst.
>>>>>=20
>>>>> I'll come up with something that rearranges the tracepoints so that
>>>>> svc_pool_wake_idle_thread() can return void.
>>>>=20
>>>> My current draft code has svc_pool_wake_idle_thread() returning bool -
>>>> if it found something to wake up - purely for logging.
>>>=20
>>> This is also where I have ended up. I'll post an update probably tomorr=
ow
>>> my time. Too much other stuff going on to finish it today.
>>=20
>> Pushed to https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>> in branch topic-sunrpc-thread-scheduling
>=20
> Another thing.
> You have made svc_pool_wake_idle_thread() return, but for different
> reasons than me.
>=20
> I wanted bool so I could trace a wake up due to enqueuing an xprt
> differently from a wakeup due to a call to svc_wake_up().  I thought the
> difference might be important.
>=20
> You have it returning a bool so that:
> - in one case you can set SP_CONGESTED - but that can be safely set
>  inside svc_pool_wake_idle_thread()

So, set CONGESTED whenever an idle thread cannot be found, no matter
the caller.


> - in another case so SP_TASK_PENDING can be set.  But I think it is
>  best to set that anyway, and clear it when svc_recv() wakes up.

Maybe that should be done in a separate patch. Can you give it a try?


> So maybe it can return void after all.


--
Chuck Lever



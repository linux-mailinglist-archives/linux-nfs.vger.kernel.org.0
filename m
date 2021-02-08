Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C8C313853
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 16:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhBHPnL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Feb 2021 10:43:11 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36874 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhBHPm4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Feb 2021 10:42:56 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118FU9V9108895;
        Mon, 8 Feb 2021 15:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ViWQpgcpxGm462BUxPAfmkK19LqEyNZu4sRKxaZeccg=;
 b=HUatLQ0G5mddDc4FVVc8O0UByr7cqRPpkn8BzKclfImXBnauqPHyWCj+xur0DsqF+Nr8
 EV41B6upbVUcGRCZx34/jX7MdR7Ro9HBGMKJMS0mZmsBIdVzxA1wZckWWavq7TYI8eUg
 iwZwiItLUeV+XTGGyXK5liSx1ChBpeHtJpPtR6nZkpMjNEPbO/e4R3NGWixTByl4f8gL
 Eo+89LnrXrN/sa1KXGfI75gvjkjjcvTDwP70N329vnTLngLIDmhJkPckn/8ikGBq6Ggt
 hcNr6pT2YkfFrLMQJVj1HNdeTZOxwrRhQsuvfyH8Vb+dxZ2LFP410qt8Xdjm524sN9rZ 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36hgmacdwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 15:42:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118FVLW3148530;
        Mon, 8 Feb 2021 15:42:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3020.oracle.com with ESMTP id 36j510099n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 15:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJ47VNixBea1QfiWOK+amWnDlCgvnXJ6QNp9Qt7DPmszJCeVpwOBNdn1ZfDRsKHG5GwYk5Al/EWGr3SDyVAjmLHj6KJIcN2Eeahje/seylh3B4nSW8pvMNPslCrrAqiVFtNCg3VWwZjFcs+PvTxkTVxGzduwNKEPch4ts2Lq1DgMv5QoYe1iRM1q2QRympo2JLmdYojsKILvdkZuNMyL/s7m7zCIOABadbo2YOT0LJSpfWdHN8IkEAi3DZ6bUwN85yHj4sPrPF879U4ezOUGk7wGbR7yyibA6WORbhcPu+QuufwqbF4yCz0DZr9Au85aEIvXxC4j2H871RtdZyDbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViWQpgcpxGm462BUxPAfmkK19LqEyNZu4sRKxaZeccg=;
 b=WGeujYFThJp1+h+n87Vxye+v/uA8CNmUGZ2ADFPHVb58hh13BR3cXVla/Ik8hfXFaexjLlxYXhAufI6bBk3yqEmGVmnQcZK0bgxwJWnbspBE8+jefhti4mjbhum2yOe5VEkQnE0ZQKrnjIeQtUaQmz0Urg3B1Bh14LlSK80IfuB2FUbWt2bKpWPHa4GF10bLUvru7NkmENjDcSmZGDH8k881cJf5qA6/7KKCYw5jj+8hyLwWLoUVehzT72zQhmZCy8EucC6OAV8vc6xF/wOqN4dfxtAR0z1JvV5tdzZ/jkKBIvn1Y3j4tqKuDpGqdD+Sh1/BsptSIpkt52MLea5AjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViWQpgcpxGm462BUxPAfmkK19LqEyNZu4sRKxaZeccg=;
 b=yI7KG9DAKAh+29eBbI7L+aIXDT33sMg2IG4cq9s0KL5YhbVl4gSLXoZUAXcFdDfwlyNj8RHsaWVmEzyRuQWI+/xl1/lFKzMifT9C2Z17w0Esk3ykeItiSTfTetuejnWx1NMmgwx+97EFohJLzZBu0TS7L2I7nERAbk5AigdA0gM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4781.namprd10.prod.outlook.com (2603:10b6:a03:2d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Mon, 8 Feb
 2021 15:42:07 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 15:42:07 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     "mgorman@suse.de" <mgorman@suse.de>,
        "brouer@redhat.com" <brouer@redhat.com>
CC:     "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: alloc_pages_bulk()
Thread-Topic: alloc_pages_bulk()
Thread-Index: AQHW/jD0BkPHybea70e3Odz69z/28w==
Date:   Mon, 8 Feb 2021 15:42:07 +0000
Message-ID: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5914e5fa-63d8-4a4b-b56c-08d8cc481767
x-ms-traffictypediagnostic: SJ0PR10MB4781:
x-microsoft-antispam-prvs: <SJ0PR10MB4781C07A3B3B7E506C64C9F4938F9@SJ0PR10MB4781.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BHvfLmZLl7nwPeP+BpnqwAEh/z1Faqmg67km7hMzxIxk0WFqCFl3h0R+0piHtnf8k/mZxKTjenwqTIfq6T8rRmVctmthmasyqdyepwRiY4f8vTggCGrMiXn2YwWrcfdJWHAv4zcIx+QSvkCmBT+FbYgg7tpDtXx4wzjaq00TPuSM3TJU0lF+XmFh2WGA4ZWFNGYfe/eYZBRi0u5hQZenqXN5sjDuPXhXjO8YS/RdUhw/PVJ897RYQR2GZGnuHnB9VjB5b4663T8Sfsd7awCgqbeWfE/pcm8Yw/pChgXE6HHP0oINJs4N1iLFhtQcPR+9K+f/6k3OBABcx1/MEEcKNlO+PmXcy0hyGcB4uSk7tOVa7sVc1hRtH/v/yUnnAg0R3qt43ku43rzYyz6oNIqJ7pTAMZ+iKj/R0xFjuPVKLu7N9h9RtYkoNdO+3kXGFWZK75ZrfTlS/qSJZs65mr75Q4suRVDeIUL7ObfQLDwgEKIcIax69JSQKg7t8j6ZsFuDpV45s9pb/hgZ1KP/mdKlIua5huxXePLuMsC9GnzFtmMVWsPiBcVB5LKLctisiOvqvPgJqnNZ+tA9KWMamf5fgHjxxq6Ccpw/Xk/VTkgoyKFgzvTIMeAHlMZD2VMfGuD3NLlcHWEWCpHD7hW4Xz/sNGGoJp40JngWNhVIHDZ2zl4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(39860400002)(396003)(4744005)(83380400001)(33656002)(966005)(2906002)(66946007)(36756003)(64756008)(66476007)(71200400001)(478600001)(6486002)(44832011)(186003)(4326008)(8936002)(6512007)(316002)(5660300002)(7116003)(110136005)(2616005)(6506007)(26005)(86362001)(54906003)(8676002)(76116006)(91956017)(66446008)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zgNtWwKBGXZ5RaN4+ykNn2Z8VshC7d5s2tP6x7fGfIDVQtaIQV/oteP2Ad0R?=
 =?us-ascii?Q?+5oXrSBzbzH1jjfKM10cSxRuHUxDKsLmAug9mjjwnTB+ZkjxuH268QtzkcXA?=
 =?us-ascii?Q?rOBFqaizEzx2QiZWy8DXwLSRwtUaO+66dTdL4fVM3GpodbPotmPkAYxQLLT4?=
 =?us-ascii?Q?bLGGPgQgW/IthAvqzzU8p/nTY96eJbXL4t98vNet2V10TKzgEM+V/PLCXDVr?=
 =?us-ascii?Q?gCdIYVtG4H3M57s6hH48cNluElERQ7G/NzPfG9Y2H1qSXgPuS/mUVI2FIXiG?=
 =?us-ascii?Q?+5vUzXyCSxvuI5cm+KA7Brbp91h39MOgSMG2cJyJshTs5NPI3sxn99PvBAXr?=
 =?us-ascii?Q?eyZuDho3ijbCpsx18Qn95gyRCjyps882MpMlxyn5iXnM/kJHSsbxY9mL+qbp?=
 =?us-ascii?Q?FPtvT6gc3UsvGpdialJ3IDllUD/4Asns+mlXYQbMQd8ZvTEHWyPWLX39RG19?=
 =?us-ascii?Q?O1Wa9ljQB9Sak/H4hYYIf85ZGg3edR892+phdcksDxEgeTijdT06hdv4JF7C?=
 =?us-ascii?Q?TqIne+7zdYPayDC+oL1SiwoJdF3o0hitiUvJbmd2R0+HF8bdIQYElZbIsYX0?=
 =?us-ascii?Q?xZFMGCec19lzIl6fjmMaydQXyw+hcMzSmMtHXCGai7pg8yjTYytgDGDFLsLU?=
 =?us-ascii?Q?106INEFDwj6MKg0wS24DOnzeNqCjNeBxjATUjgVLpjfgKQ5xljw9KFJMawkJ?=
 =?us-ascii?Q?gxSCJuH1RgwONl1V9xuwP2Pg5QQGZ1JV7fyKU1VTB/2Qhv/3UF6qgQu5O2ky?=
 =?us-ascii?Q?wt/YTm1QI1vPpPgh5KJfo7ALIJ51XQCCRC0cHJfBK9PCSsGis42V314U/uGs?=
 =?us-ascii?Q?HMOSbwDxOlJ401+4KUJ1Dvp7HC/7n7UROCfTMGrVSrMpAmB5E4zO4bbBQmaB?=
 =?us-ascii?Q?VHxWuncWBj99WGhjGRIiGKE2Z0ipj0OpgqESf6RRK8mHL4V9/N9xsACO7s7X?=
 =?us-ascii?Q?KQAFwQS7nAkTDroyTkbgCpf0EF/r8DldO0RjU3jSpIEyRx+QNw+oYDSs/JdO?=
 =?us-ascii?Q?d2+pO8lTe404+wNMPr63OtT+RSLa1rCtYqrKsiV36WtHsWISoiqYkqv/Eff4?=
 =?us-ascii?Q?Ue+xrt4w9QwyjiC9Rrk7e2QAoKLbBmTILNAyxHCtitedN2TtMmST+tYL9Av4?=
 =?us-ascii?Q?IOoqYpyIw63NN2qwOkXUtIR5dCbAjPMTWETzFGgqhyeY48JMccEMu4y3lU6u?=
 =?us-ascii?Q?1T8tuDP5RBIiYzpkmbv6lLNFb800wqXEcc0gh5dK3GPuhHQmmim79PoplSeX?=
 =?us-ascii?Q?XUwwh7F5IoTJH9fRUQq6matBPpkjup6XEkffo0TIdOS2YYXEj0eo95GLabKj?=
 =?us-ascii?Q?D6hxYHCmWazJ+6ylAg/OeTpC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4B4D365699BF640A7BC39441BA72E84@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5914e5fa-63d8-4a4b-b56c-08d8cc481767
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 15:42:07.4383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8bzQVCbUsK4S7jufjFfshj8+Lc3U9RBU7oRNgXGOA8KH71eQXatY2DHwDs3n0qtLa6NG7yN8NZzAjnwnyi0PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4781
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9888 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9888 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080105
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

[ please Cc: me, I'm not subscribed to linux-mm ]

We've been discussing how NFSD can more efficiently refill its
receive buffers (currently alloc_page() in a loop; see
net/sunrpc/svc_xprt.c::svc_alloc_arg()).

Neil Brown pointed me to this old thread:

https://lore.kernel.org/lkml/20170109163518.6001-1-mgorman@techsingularity.=
net/

We see that many of the prerequisites are in v5.11-rc, but
alloc_page_bulk() is not. I tried forward-porting 4/4 in that
series, but enough internal APIs have changed since 2017 that
the patch does not come close to applying and compiling.

I'm wondering:

a) is there a newer version of that work?

b) if not, does there exist a preferred API in 5.11 for bulk
page allocation?

Many thanks for any guidance!

--
Chuck Lever




Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFB43248B7
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 03:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhBYCCh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 21:02:37 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:1215 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbhBYCCf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 21:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614218555; x=1645754555;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=s7IW0HYVk6fMLeKvgdaTQRE6JJHdgmGG9SeNzZnV1hw=;
  b=MXt9r5odI0t7h9/9zND2H8KTjHZUcKYIbTwkMfvGnL9T7cIBc9g+PUlu
   Ik5LsuXJNwIk/rLeJ0oiQ78fMHKYPQ9ZFLdbbOsDIRW6ozXJu5FqSQGoq
   WTjHVaKpnu6EMEwTDnQ4L2FcLkriZpKHqlC4q/l9ILbG7BvrRZE8+chUK
   B1xTh2nE7q1nHpXDmLcg3vJiLWiVQghVNwpKY9Q86uTt4jQFVA5YPBiLb
   70HEJfMigUHvUmOCAHIQNyCJNr1aJe2bp5exPWEYCKcCgvhbpd+JBpWtW
   arWdVhbIYAXiVBYNsm0K+KEYoSMttOWe26smyGNsbhfeLgiMPYzK6xma4
   A==;
IronPort-SDR: dKO7GnsPekgSoofHTpDkxvNtFgqIYGdlMf7rNmG2qdZuQVwmGBh78Zzwi0kbePO1TGJjYLePgK
 9ZLoJELIdXtOLF7sKE+oFFTNbnhKYhm7XhunC47uH8FsRmgGTku+Hj2wFq+oG0i7I54c+dwnGV
 TtGdbEu1Cbw5QjTg2WxXXUleBg9X82BrB1An8Uyq17pSIgowP6dSdmQhtoPLvge868Pvyycr0e
 NEbNLQ1/dWV/92ogGEt+f9ae9Ob/gBQBvj8DSsuiNoqP1vSm3EcgvFJlc5w3W/jkqz7n0gJIdn
 QgE=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; 
   d="scan'208";a="161914056"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 10:01:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfCPaLlAFDuDTNWmt1BWxUcmgCXf/P9mWtVcDRQ4GZjzY1N+qcZdVudNiiws/eg5uzzskdf1cmqvSFHqmmiCz2/NBO+ZyllO1tc1tU1t8iatl8UyCNkjpCuD/ldHlMXz80vHBuE/N2hTElLv4QWw6hAJvXhnj0YtJAIrtP71tw35LzQZl+a7F40oRvTwflgVeVgy4sUgIPlDakpCTCJGz2Pzfgg0boDtouOCEhLt/MblNrdp3ri4OX+qnUFaf4E5fZUNhm1NjmDqWpYHcG98hRO+Ci6P4UFWaOa4Os3NBpNSePOqu0QxeJ5wZBPqRvEvmqXSM1LuCvnPBaXVck8pvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa8HFMpdFgWf68dxRdtCs8y78Vu2x/tPoXGVbPCMb70=;
 b=kvbHOMpSQNMvE6QTHlSbllzy8tFyyf2p7J4QNv2djFqdyUZhnwVlhjDW3bFsblWcaEZ91eSgHl/Qe2g1Hs5zU7FP6Ocjtx22F+pNAea5SWE/Ipo14Y7nNs79KRRvjGQ8b0WTGZA7pJY5iK+m7ew0SH/3X/BGhN5PnYSdY+wCO+UnZlurhr2n/8gtCzhGC07y7RTdy7ALd4qLX3srE1w6HWwyHY5q4NG8hWD9wc3FxhkwgStBnm/wnJLjbDJwFoujj0SFlsxmM5hbnuzASv60pk41DYN2jBbLyySUYiZoKv1PN7aCqcDliz1xazRhr/A4KxOgrdA6KoZ6wV33ZavTXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa8HFMpdFgWf68dxRdtCs8y78Vu2x/tPoXGVbPCMb70=;
 b=g3NS2szVFCcp2M4QC8OHlbNU9uABbw0txXiHyzTvDpqPN5jv7/z7OALwtpvvk3brhEPO53Y9BYkYIdHdoPSo7reKWQx8e6yWd3cRxXvc9APZesOjfEU/zF4h5Fc5pZlTh29+j/A6TTsbyJdF507XXATSY0Fjp2DRp5hk85cIaVM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7501.namprd04.prod.outlook.com (2603:10b6:a03:321::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 02:01:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 02:01:22 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Stefan Hajnoczi <stefanha@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "fujita.tomonori@lab.ntt.co.jp" <fujita.tomonori@lab.ntt.co.jp>,
        "tim@cyberelk.net" <tim@cyberelk.net>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "bp@alien8.de" <bp@alien8.de>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "Kai.Makisara@kolumbus.fi" <Kai.Makisara@kolumbus.fi>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "baolin.wang@linaro.org" <baolin.wang@linaro.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "zliua@micron.com" <zliua@micron.com>,
        "richard.peng@oppo.com" <richard.peng@oppo.com>,
        "guoqing.jiang@cloud.ionos.com" <guoqing.jiang@cloud.ionos.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH] blk-core: remove blk_put_request()
Thread-Topic: [RFC PATCH] blk-core: remove blk_put_request()
Thread-Index: AQHXCV9JZjwro7cFh0S/a18Ze28sQg==
Date:   Thu, 25 Feb 2021 02:01:22 +0000
Message-ID: <BYAPR04MB4965BC5C807658B3B433364A869E9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210222211115.30416-1-chaitanya.kulkarni@wdc.com>
 <YDY+ObNNiBMMuSEt@stefanha-x1.localdomain>
 <f3141eb3-9938-a216-a9f8-cb193589a657@kernel.dk>
 <20210224185521.GA2326119@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56f64fd6-2cdc-4abd-c521-08d8d9314028
x-ms-traffictypediagnostic: SJ0PR04MB7501:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7501900745C1A3FA0C31A251869E9@SJ0PR04MB7501.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7a1exBGRqQktlYbDDZWv2RhRFbhqGiukSq1LW0aZf3mzSh5WjzQ0k37UaKivHB3QEqnT9Wur7CkpX+vSiETNDt3NSyq6uqQPXxQx8vT2+kX6HidYPZZfKA4AMREZqWNDIxHeHVbqqljrwyhaaVOTGcUqvm6sGgZTYfcIvBNAgRYX6Qn44w9HEnIwg1QfMxiNBDjbwkdEraaDj/sVin/H+pKFGLL8wleEXxddVYG8b+6z9pdN7UUteFeLXk+tkWsG/ul3IHa5DHsVW0SdIRIegIv222OApq7ejFai34kuWmA3S5msKWv3KWtz2xN4AqgBfZvymnHGA6AQ7CpY/Gy4jmTbcMAciS/TYQgk8K5r/oiW1hJ/p9luedxeRigmWLfTJYEpPG7JI7qypZQVqt+C2qQGKSKfobtOvNuQHOjwyKKuoAA/Oo6+93h4HC9vRQS9HEf1RBI/RYjmcpnpRfVdlL7kL5JENlMiv74DTZuiNJMt80b6wSjAmfq5SJCvL1Txb2FtVeghWLpxck6gbzK/4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(478600001)(86362001)(2906002)(8936002)(6506007)(53546011)(8676002)(110136005)(316002)(4744005)(83380400001)(71200400001)(7696005)(54906003)(9686003)(7416002)(52536014)(64756008)(7406005)(66946007)(5660300002)(76116006)(91956017)(4326008)(33656002)(55016002)(186003)(26005)(66446008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gcZ7mh0KhEVI2AXURnV/bTrU9dnz9UR9APEeZ7x9qou92Rz7vl2RzC/fbjrY?=
 =?us-ascii?Q?OTDF2iQDykaxfGyfv2YBcgXg5C83VQb5TvWkb1UpWurvb5exQF/WrZkHdNgu?=
 =?us-ascii?Q?+0shO59m/wJVG5GwrC+hrItJ8wubPmOH09fcDsDtohjqU9fH47lNSpjjYrdN?=
 =?us-ascii?Q?FXGW+KYvNxJMFc6Rq/KP+XYhNhlSNcRbjZzsluj3BD8rob60NvYNbr3eGTwf?=
 =?us-ascii?Q?srbY5MA0yejRIIB4+tkZFYtegkiter+kEiMX8ctN308x41CmIUPbas0/AhxX?=
 =?us-ascii?Q?70nq+AMoqQ1M162pw9nrSyPpQtR2suQmC5lLIkTc12rkX+BVlMS643myVAqs?=
 =?us-ascii?Q?t4bHc59aLOIMw5surFL+VQiREZ7onYNixaRkkFcWDJ+4ONN6jF5VuxQlPN8k?=
 =?us-ascii?Q?4b8hbjfp7e3lZhiwFhFMXF0qLkZGEeJGNRDxxkQ5JIHV5xOL+b3/ywtTQYKg?=
 =?us-ascii?Q?9gclzxjcvgvZ6H7VXN5dZBtuCQPiPrDj/0Ov8iVJnyc7so1gTOTFeEHb3wMt?=
 =?us-ascii?Q?6W+HumdT7ELVp50t6qkVhw8ASRl9D7gr7piv5srMD13jo9yyXYXUiI3iHA/m?=
 =?us-ascii?Q?ajkQ3IO8GQGLa7qo81l3pcRGUGbMXvSprfZAy+3RTetqfUzmoHd3r01ojv9s?=
 =?us-ascii?Q?KWKZAN2A5UUCEEJWn/S81y8GT2Q4JhOTa+MkZIsSzLpR8/Rohw5quJKCPnHV?=
 =?us-ascii?Q?ERsYm5nvsKu5KtNB+5ZXSOsz3+j+N95k6tJik+dHf1pLRWYOi0AeM0XjGhT2?=
 =?us-ascii?Q?iV+hoIUiS5hQ1aIvVm872bpstxU36RJwDQhtzotyph9Epb2J4NxISFIJh3wF?=
 =?us-ascii?Q?2oSZMPnP2RocZtzP14OEgooDDhnfDYUmctmyVOWvJ1JQZfw7YFRdn/hXz06H?=
 =?us-ascii?Q?7y2N6Hcn9E6MWZ4RC3+hGANhnkhJc9JbH38HgIMuPDM3ainXyCikgANltpdq?=
 =?us-ascii?Q?fF5+XQlDpaHWquODZSZ0sE3yPLj+hIEFjDpTq5XSRNMt38j0lU8vCeT7CcEP?=
 =?us-ascii?Q?q9SYFaLnd9g3Bvs5epKhxo05IyZ/qov3SOHEY6icvHvHvmdA4N4V3a9xy11a?=
 =?us-ascii?Q?ljNVIQMG4g7clxi94FGSC/OeQwDdM9bUFZQeOJOHjI9x2KqDVMi3EhctPgEd?=
 =?us-ascii?Q?5d5XMRvbtqXkdYEhT2PMPCMELwxdJIcCavnTWWGQIVkWqQZmAk6PVRVPyH0B?=
 =?us-ascii?Q?QvxFBJd9mN87Glf6+F9JHBBE2P/xqyOEzVhZWzxrWoE2Z0TY4wLJf7b9kyiC?=
 =?us-ascii?Q?2HTTYQWH6AtSm2cqj8Bzd558VP865DO3ZmNWMP3vRH52PXI0rGB20YyUMwSW?=
 =?us-ascii?Q?p62Tq+6banbFmnFbD2A37jRhcvu8KVHVLrJuIqQV16aayQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f64fd6-2cdc-4abd-c521-08d8d9314028
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 02:01:22.4144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4h07uujdgDMaaLd+E6bOJvg9EKRXI8nL3l5DC6R3D4oFAfvDFXOiwV8CiczABQqDfr6y0PDGXBQhUjggbo4Jw3CwrTBGIPr7xseE97cCEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7501
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/24/21 10:56, Christoph Hellwig wrote:=0A=
> On Wed, Feb 24, 2021 at 09:48:21AM -0700, Jens Axboe wrote:=0A=
>> Would make sense to rename blk_get_request() to blk_mq_alloc_request()=
=0A=
>> and then we have API symmetry. The get/put don't make sense when there=
=0A=
>> are no references involved.=0A=
>>=0A=
>> But it's a lot of churn for very little reward, which is always kind=0A=
>> of annoying. Especially for the person that has to carry the patches.=0A=
> Let's do the following:=0A=
>=0A=
>  - move the initialize_rq_fn call from blk_get_request into=0A=
>    blk_mq_alloc_request and make the former a trivial alias for the=0A=
>    latter=0A=
>  - migrate to the blk_mq_* versions on a per-driver/subsystem basis.=0A=
>    The scsi migration depends on the first item above, so it will have=0A=
>    to go with that or wait for the next merge window=0A=
>  - don't migrate the legacy ide driver, as it is about to be removed and=
=0A=
>    has a huge number of blk_get_request calls=0A=
>=0A=
=0A=
Okay, thanks for the feedback, will try and get something together.=0A=

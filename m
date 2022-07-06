Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3911B568F29
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiGFQ3S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiGFQ3S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 12:29:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EA820BE1
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 09:29:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266GML6q021457;
        Wed, 6 Jul 2022 16:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fCUGurZatfYqQU421WrCKkFxjSupkedRKsghKNx3d10=;
 b=akbYEYBFsIDtc1dJr5kpMOK7hLqn/BKYg0DaLzoO8LhSnD6mBsGyeOM9gnX3H9yeMTq9
 LuHJPV6aktvKiFT2IZ8dx9R4V5cGa9kRCtyx22CFIhcs+tawmmGnR07qiAnWwu7td/YK
 raLNRypleMjGDUTM7x0Lf6z2Y3dlwe2KpgCZ5a5egTQWBudRhsSnnTAcy58LMVnPWxBJ
 7GU/GuABczAbLR9ecqRDKaqAsBZ/1pRXxD4Lev3D9ZiYiyDSCp/rhJJ/f83qjiSOOPiX
 f7Xai2iR0LzX7tlB42aFA4N3YyEJMSwekw9u5aaFCyaHgFIkJad7cyJdjAtZMbGSBn+e Lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby2kd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:29:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266GBInK014917;
        Wed, 6 Jul 2022 16:29:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud67m8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 16:29:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIoQUyMI4bCtfImb0XBY0J9507S3dwxtebhxLjll4vL2a4QrAKid4biokt4bQUxMc51Wlrk9Bw3/hQt491juQWlzNmGgwS+TZ07A6bHzzi22ek2X1Y4hh/z+M3QZPlSG6uKmShYGuH4Z3mTdWOYcU9CwHLOQ3E/MzP0bv5juNynCCX+8WJHRNYaydfixeqKYPtFPPE4ivLr/eyrOer1bLe92NDz+7cwK6hFnJ373KKTXG4Grc1PiojXQe3eO21JSkr2i3w06jQgJ8VLmUD4BwZSKQZ+FraFRcljYlwkyUXy96NVVUYMeBEC+vOHe0s4VT0mxf/Vtxn9ebvuTyzAEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCUGurZatfYqQU421WrCKkFxjSupkedRKsghKNx3d10=;
 b=AROJs94KvOZ4m2UfCw4rA+DrIwaP20us6bZ+QhS4cDquaNOr0U4NAme9XC+DvQqyq3uf1DAvmkbVVwKA1Dg2j19V3DzgyWta9qxfkjdD7P4ZcDCB64BFZXtdy+FJN85SiiFSSlH5apsnr7xwFQNyPEBoqK0VxOYA+abAo7v7cyuaZ0RpLn1SiCdPmDrXfgCig1Wf4mMdG3Ik+8inzO21ynidrwoHdY91XsKz90mSGeizCwZg8ubSOyrTBE6rYhEyV6yC65CSmQmQTiCwaO894vWktvP86T4nmByDepOKXMDaU0z/RZfG0cnOX/04rlZHlCRAybZM6on8WoOJkdKNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCUGurZatfYqQU421WrCKkFxjSupkedRKsghKNx3d10=;
 b=hQlPJ8kg1AFISXrQHXO2I7jv0SkUUMrtggTDXn41fFbfagakr6IIUaGs6qcVLWnQGvHy8lY0ADvqpaKx8Ixf0CbaE5tY7VzLvFt+7+T5XLSgNPl2Xfpz7gLRoEDLsQ1CzvU7fJ/uFDJLqWEyARH5sktt/H4NkF78t2rNGTn7kNk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BYAPR10MB3063.namprd10.prod.outlook.com (2603:10b6:a03:89::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Wed, 6 Jul
 2022 16:29:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 16:29:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] NFSD: clean up locking.
Thread-Topic: [PATCH 0/8] NFSD: clean up locking.
Thread-Index: AQHYkO+nUhzdndZueEy9RTo7pT1nKa1xiSYA
Date:   Wed, 6 Jul 2022 16:29:07 +0000
Message-ID: <3FF88D5A-9DBF-4115-A31C-6C6A888F272F@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
In-Reply-To: <165708033167.1940.3364591321728458949.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df101344-67bd-40cb-8ece-08da5f6ca601
x-ms-traffictypediagnostic: BYAPR10MB3063:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQHrBHYL7S47meLLcpfVMEAH4vUtpjJIzz17jCg02T8knJ44fnyoKkx0y65JOTGl61kSHZXJxtZA5qslMmi7810K0NE7LIpcg6eZvxJdhA5MMzu7vpRicaBoZwWxcushGVtRYdlV43wY+xbSfbadmpQv5SdjXzUVR2QGr6ZZl33syKA5cBpy8yKNgaebk5fN7ovgpXhtsdiOSn/qtvcdETzdkAobyrFa8TvHWB1/TyIHcmOqYNJo07PcjZxly9ePq7NzTeaT8HZ65+1/lSqQr+o/G2MaMIFVLqm/HQIf5pLF+g0xmDmOtrso2rWjsFcPTKQDHMrHV5pyUUrFqw1SNCvvgOr6g49+pClr0hzNqqIoc4em6kjPYpv20C8WXpWwopzT5ajOqurLfIzbEB3LwtN8HQQx1bzblQLALJ2PoSWIv/eEYAcVz+PNrB6xSzJR19BrSj1xIEWbdHn8TsYZsJRT2Tw6Bhgp2Jd2x9YV/j+wKTzjzpQv2QYJWpgeJM25U25Kh8IUMKw/ZeWg0rUA9qP2EFGgK4ikUxF19+TYwMZ61KXljfwoIJM69ZrhuVif/VLuXiL6scQtUlXX9jT/cJib0ilmwv2CAwlMSONXoruBST6MhNQtzQTbQ53rukAsCRI5+xnxTHBieM2CqOyvLfcUGCHtSMm+z70zXbSnZfAP48Eoh8AO48fWz4Xj8LCAIpXx1c7D4R4pHnoNk4sfz+N4fVWHoCEEDcysjB4BzipRwjXax1K6kXjI/aIyZM6cAJE08Hhoa4l8ehRErQ+nX5fQ85/DqXBEYOVbNXAnY1VAQOuVoOk+obzbza9DdKLblhLmgFDAsBXZjnds/JqPHxm7Cxroo5ouvgRBJ0lHKpQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(39860400002)(396003)(136003)(122000001)(38070700005)(66556008)(53546011)(66946007)(6506007)(41300700001)(76116006)(66476007)(91956017)(8936002)(66446008)(83380400001)(5660300002)(4326008)(38100700002)(6512007)(8676002)(36756003)(26005)(64756008)(2906002)(6486002)(478600001)(6916009)(316002)(33656002)(86362001)(71200400001)(54906003)(2616005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+822D3UgEgxa4qfJ6FH2pXhki+NdzNX9HiMW0hIiwiYwcg+WEKd9l5JUcc+L?=
 =?us-ascii?Q?AwdBonzeTTCziADNyW26p6RUynuSD54xdPybsvLQyhH9FsPfqhhw84xI0jJe?=
 =?us-ascii?Q?+DaC4Zaif64iD+iPWpMFywZGMgxA46BsVYgG716ncWtvNmX/G5viKVZrf08u?=
 =?us-ascii?Q?xgA4Tid4notGrdfMKMotHNpaZTDettSs6FSpug2W02QcpVaVlcza0owiyAfL?=
 =?us-ascii?Q?qee0+BZ3WrseyBUCl/4JGqT82Q2LYzkEMa3KHWXtVEExCBIo3AGlbrQQb3kn?=
 =?us-ascii?Q?I3NbgyFerbLrv3K4Gt9iPIma33a/85TQOiAXrnBhiyex1W3T3RkoR+OGKZq5?=
 =?us-ascii?Q?Ewx6GE3eLB+WXxVEKcvTiRrjuLda4MsCqwrQ+AgcO8+S//X/zMC9zo03yDuE?=
 =?us-ascii?Q?kWAyJwXmbRv/TsqlrEFuipKtgPtX5080tomciUnElP7/ZI6XIkl9BDswRxda?=
 =?us-ascii?Q?dBhjYotWlxAjjaibAbokCAjCteBLokzOZzLTiWu/36X9UQqcbmvoMvln1vJv?=
 =?us-ascii?Q?YAQM0TytkPAxVb7dFDn4MtN5/JOLaYAKmJMdBLhWLBb9Q3Sm4+4bMpZ1HOtC?=
 =?us-ascii?Q?0wCmN0WO97C30LY6e6WJUSfSHqmWBPVaw7E9iyqR4BpT72IadEUg1wC72ryu?=
 =?us-ascii?Q?A5jVtokcvOV/al0GnDd9sygDJERmnDGUcSiYOqfqtLP8X+1fBwI6qCDXK4//?=
 =?us-ascii?Q?sguprvWgscXl8VEecpJ0jWaT0f0u3qXhDw+JpQDRc32ARu2CipHYIFc8XxCM?=
 =?us-ascii?Q?YK9JAU/uuf+ORf4zBe+M9WKkYP4k6XyOeeJQygyDnG/Fb55bdSd9NaX6OT4D?=
 =?us-ascii?Q?3KhOyN0E2bBl6TCMVcODyJ1Cp0h/FPu+KgiECTlRGf52hgFWdMig/fckg7ex?=
 =?us-ascii?Q?a7t+EI6/79SQ9gf8v5Wy1+Hw73mFMZeoon0nXqgcDFLHCC07QSNtPBkv++JV?=
 =?us-ascii?Q?EipGDybyOgn28lbRJUUDY9h6gReZ8udg8zbBsbkoC9cs4ad2ymz6sSiWWUib?=
 =?us-ascii?Q?l2A660Sd2Misg82xrtmUSKuTD32uhlSWdoKR7VdcwSgPyOkjFX0hCIj2jU/b?=
 =?us-ascii?Q?fC+vpDO54tcCebohShr+lQXT8DCrTWpb5kmJe+sFoeWNr3h3gWddc1/TgXc4?=
 =?us-ascii?Q?0aVVYUP/Xje/9Vgx3PnatAyTjpQCNSP3lDqVciF7NP1EI5o+3JhGx/jyGBf1?=
 =?us-ascii?Q?ZT5J+VlSoB6ve/hPvfUtvh9q2VL1YoSWUBkEXPSoK7OIcGyJstmmjuqSFRdh?=
 =?us-ascii?Q?IKd53Jvr2q+0A6hHxpOW6Ww+vKyFL1aDyYifUAR50MmcRqNdun8slDWScqUU?=
 =?us-ascii?Q?49jtflRXc1El+G9o2vjJZc/Qm9Lc8yChf/paG0m+I0wYu3Oj5UeUSYDfBnEB?=
 =?us-ascii?Q?OwxRDK0O191IXjpULTVhK1K3yOoxxHkQW2p63CAxJkMcP5rDhr/wa6QFlnpv?=
 =?us-ascii?Q?1ASxsa37U2mYluqAq0W/IQeoh24OX/ECJG4LWOtTok8iEnlbJRAxt4eaznBS?=
 =?us-ascii?Q?vOO4jT+I8uOZ1KK9JCu/yGBv72eybLPbUZkk8+g3SqocOD/0sTMVfLu6h9xY?=
 =?us-ascii?Q?xuwKyXXWV0/r7PB8Kr8sCxTWW4F3FIVWc//tjTgk3PeTP3DUggUL/cpiHGJR?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E68360CE7A607443BDFB452FEE781074@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df101344-67bd-40cb-8ece-08da5f6ca601
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 16:29:07.1948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTEr6ufAQHRrfclTyzi8/+NdDYGyXNgxvMa4Vacls27WzceT7SGV/B2sSO2Y/0vvwel8gmTCtbjBhd3wuewrvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3063
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_09:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060065
X-Proofpoint-ORIG-GUID: qEaPjZ5IM-7XmUkA5QTEL_dcOyT5hprF
X-Proofpoint-GUID: qEaPjZ5IM-7XmUkA5QTEL_dcOyT5hprF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 6, 2022, at 12:18 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> This series prepares NFSD to be able to adjust to work with a proposed
> patch which allows updates to directories to happen in parallel.
> This patch set changes the way directories are locked, so the present
> series cleans up some locking in nfsd.
>=20
> Specifically we remove fh_lock() and fh_unlock().
> These functions are problematic for a few reasons.
> - they are deliberately idempotent - setting or clearing a flag
>  so that a second call does nothing.  This makes locking errors harder,
>  but it results in code that looks wrong ...  and maybe sometimes is a
>  little bit wrong.
>  Early patches clean up several places where this idempotent nature of
>  the functions is depended on, and so makes the code clearer.
>=20
> - they transparently call fh_fill_pre/post_attrs(), including at times
>  when this is not necessary.  Having the calls only when necessary is
>  marginally more efficient, and arguably makes the code clearer.
>=20
> nfsd_lookup() currently always locks the directory, though often no lock
> is needed.  So a patch in this series reduces this locking.
>=20
> There is an awkward case that could still be further improved.
> NFSv4 open needs to ensure the file is not renamed (or unlinked etc)
> between the moment when the open succeeds, and a later moment when a
> "lease" is attached to support a delegation.  The handling of this lock
> is currently untidy, particularly when creating a file.
> It would probably be better to take a lease immediately after
> opening the file, and then discarding if after deciding not to provide a
> delegation.
>=20
> I have run fstests and cthon tests on this, but I wouldn't be surprised
> if there is a corner case that I've missed.

Hi Neil, thanks for (re)posting.

Let me make a few general comments here before I send out specific
review nits.

I'm concerned mostly with how this series can be adequately tested.
The two particular areas I'm worried about:

 - There are some changes to NFSv2 code, which is effectively
   fallow. I think I can run v2 tests, once we decide what tests
   should be run.

 - More critically, ("NFSD: reduce locking in nfsd_lookup()") does
   some pretty heavy lifting. How should this change be tested?

Secondarily, the series adds more bells and whistles to the generic
NFSD VFS APIs on behalf of NFSv4-specific requirements. In particular:

 - ("NFSD: change nfsd_create() to unlock directory before returning.")
   makes some big changes to nfsd_create(). But that helper itself
   is pretty small. Seems like cleaner code would result if NFSv4
   had its own version of nfsd_create() to deal with the post-change
   cases.

 - ("NFSD: reduce locking in nfsd_lookup()") has a similar issue:
   nfsd_lookup() is being changed such that its semantics are
   substantially different for NFSv4 than for others. This is
   possibly an indication that nfsd_lookup() should also be
   duplicated into the NFSv4-specific code and the generic VFS
   version should be left alone.

I would prefer the code duplication approach in both these cases,
unless you can convince me that is a bad idea.

Finally, with regard to the awkward case you mention above. The
NFSv4 OPEN code is a hairy mess, mostly because the protocol is
a Swiss army knife and our implementation has had small fixes
plastered onto it for many years. I won't be disappointed if
you don't manage to address the rename/unlink/delegation race
you mention above this time around. Just don't make it worse ;-)

Meanwhile we should start accruing some thoughts and designs
about how this code path needs to work.


> NeilBrown
>=20
>=20
> ---
>=20
> NeilBrown (8):
>      NFSD: drop rqstp arg to do_set_nfs4_acl()
>      NFSD: change nfsd_create() to unlock directory before returning.
>      NFSD: always drop directory lock in nfsd_unlink()
>      NFSD: only call fh_unlock() once in nfsd_link()
>      NFSD: reduce locking in nfsd_lookup()
>      NFSD: use explicit lock/unlock for directory ops
>      NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
>      NFSD: discard fh_locked flag and fh_lock/fh_unlock
>=20
>=20
> fs/nfsd/nfs2acl.c   |   6 +-
> fs/nfsd/nfs3acl.c   |   4 +-
> fs/nfsd/nfs3proc.c  |  21 ++---
> fs/nfsd/nfs4acl.c   |  19 ++---
> fs/nfsd/nfs4proc.c  | 106 +++++++++++++++---------
> fs/nfsd/nfs4state.c |   8 +-
> fs/nfsd/nfsfh.c     |   3 +-
> fs/nfsd/nfsfh.h     |  56 +------------
> fs/nfsd/nfsproc.c   |  14 ++--
> fs/nfsd/vfs.c       | 193 ++++++++++++++++++++++++++------------------
> fs/nfsd/vfs.h       |  19 +++--
> 11 files changed, 238 insertions(+), 211 deletions(-)
>=20
> --
> Signature
>=20

--
Chuck Lever




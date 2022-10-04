Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A05F4536
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Oct 2022 16:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJDOMx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Oct 2022 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJDOMw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Oct 2022 10:12:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65E860688
        for <linux-nfs@vger.kernel.org>; Tue,  4 Oct 2022 07:12:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294DPVpD000370;
        Tue, 4 Oct 2022 14:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AvFsBSkEFEbrqYvAbvZC0/P78aRytaEtqrWY0uRj4cg=;
 b=MioDWZyPUODiDzty4z+YcZpcu/4YHhcwaSMKznb/JZCLQsGMvE9hF7IgGx6jtPcjPHRR
 5QKT2Eh2LjXCVivrPH6Xdq552xfGFn2pzpqSFIHL0mXSL2nJSQEeAExqE/RX7dpuVnbE
 Q4DedstLakUOSZAdgIw9DUezt+mClrwFE+CBM6q4dZ88JcJS6B9PSeelPw2/fIeNOiqt
 3+b0Eu97y0nPLwB+o7itW/SwD0a07Mr0C0532/dj0GPkGhWUYXdWAq9tL8UwzuX2VDnC
 AsrM3a4CMMU2w7AXcSxFcDOgWTrXp+5uiHbYjAbpIBS5F9SdFJo9qR5WmhhsdvRxzAcn Ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdea6nu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 14:12:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 294E3tiQ000588;
        Tue, 4 Oct 2022 14:12:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc04r91t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 14:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmxatLzgk3vJN0pZTNfVM2MQqWIE7nTM2tfBWYzXgNrkkq6j2LKS1W72C381fw5I8qdX6PIrWoPCSGMfeYJqJVUQpeKArMwiPhtlVyNImlCTPb29YhNfn8/aVez80C4GX+UKfgMNrOyizaVsjSKSTlm4FId9wM3D0ow3zQ/PrLdU3P4MHNI3BA1S4J2lCYKIipBIGFe23HdLekkbKJKLMttUgaHLp0Oqq52OiB2jsGsh9UGJpumXOzdVduS5HmGEIPJgeLBLezXmklaUNct/kuxjLqvxKjoE+0ZtUZwHFJP8kjcIvbMzKDLuZeXPxlI0eQ7w3TliYaVI4ibs7g89vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvFsBSkEFEbrqYvAbvZC0/P78aRytaEtqrWY0uRj4cg=;
 b=SDTFpHvkmxJhPOwlHcEYcd9HZIYEvunuC1ErQoU8KiuRmiPAbIICkWOe2Ow3JxR1ufAJj2G5S2n7AOUgyUaWk3QDJ450DjSrfxhAuL+hNGPTe1hi3NFlyw9o8r+RsVYu+M+cFLvO8p5m0cZ+hr3ogV2VybIst6kfd38oZhhxKBww7zLu/YHhEqWDKukubfAbDXT567zPH76Km7fpmt/WA7IN4ziJ14EsUyybf5VNSNyKJC1vPsuiQQxMiS1naOAlg53rZWUydfFVYUSke+3woF78Ts3uIeNJlohpdswSDB2PUB30S5BRGYxK5HVPDKjnRcKREnaHbyA5dy7odVrmNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvFsBSkEFEbrqYvAbvZC0/P78aRytaEtqrWY0uRj4cg=;
 b=tlLTgobe9imQMz+KTPm1rCJGDeBXJdsnhR7neZ8xWdHpMC9E3ZfMqhBGuMzkcYqdB1LFPKKray5P2yY07z2gHXyJwEha4fDDUUTXZ7JpKtRU3wuWPNMgmez5p8h8TxGzqyt7NlEZV6afMd/URIomftaBkRMWVPdmmcEVj7QiJow=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4925.namprd10.prod.outlook.com (2603:10b6:5:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 14:12:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 14:12:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfsd: another possible delegation race
Thread-Topic: nfsd: another possible delegation race
Thread-Index: AQHY17BC08CkcsMynkeV/ZMR9ZjUjq3+R1KA
Date:   Tue, 4 Oct 2022 14:12:36 +0000
Message-ID: <A20D72B2-097F-4240-A894-0759B53C02F4@oracle.com>
References: <166486048770.14457.133971372966856907@noble.neil.brown.name>
In-Reply-To: <166486048770.14457.133971372966856907@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB4925:EE_
x-ms-office365-filtering-correlation-id: 678042db-16c6-4f82-5d8a-08daa6127d35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a07HTb93h/sULS6icbrZRvkDyqKTvWygOOI9pb/vGgD2i+vLDy6Agkl9reybsFdcu4OU709EtHdR9+Xgg45Pjp7RS+AtcUSh0GZPwK8NDqQYZF3rg3dxOxomAof2w3HBZ1VMkKjPx36K2udNXhOkYPqrrb9JCxLAVsRiuaXrLMehtABor0R71xaddW5dqnH/QWv3MJa12yze71+VaV4JRVOSpNzMrNeTZwHcYhC/JWvJVEFPhjGjiL5/HhxRS1O7N1KA5huyv2VdJask7HOZjHyLA28mHGslj035ozKNeL081hyDFNBBxdaQO79c//SwXWdrAzYHUt6elti9m/27ybS7lQXGWlE82So+/2WK7Ub+MbE88z3ArXAeWMCrqyw53ZRWYmJYNlXAvwl2v8RtZqhzWakyGrxM/7bmvdEl8npL4eCVW7rFAoYY1+kO0PVp/pBbAmEB4fVpLWdFxcZg9S0qTV0i6TInjqj8WDKE2YF4x50LfGkaBvwfLXzr/tgf5hRScWSDpxiUTgc07zN7k2r/RuKxFC0Jfj6lkxT8MGfUJ1TrMu5aZPKkcr8sWRFHpBmZLsGLGyEg+6LWumzLRzIdgSzTHRV1TaDrMM8iXqRuMktogffZ5qZYsQ30huvMTHCTU2Teaa2P5xj2E/LFfhUjCmq1x5w1HxwtbfOoBklWAGXTScHOXMBQXa6VHR4kjgglGCBLshIypItoF89E3nVvHATKOVCrtSkW0X5XjHI+JSU9i8x2uIXs1ntAomCwN7r9N7fqT28uqgNK/15ErPnBhjUYiph/dDxxxYsCT0s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199015)(41300700001)(66556008)(66946007)(8676002)(66446008)(4326008)(76116006)(64756008)(91956017)(38100700002)(122000001)(186003)(66476007)(2616005)(2906002)(6512007)(83380400001)(36756003)(6506007)(8936002)(53546011)(26005)(86362001)(5660300002)(33656002)(38070700005)(71200400001)(54906003)(316002)(6916009)(6486002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z1TZwnpyoPzn5mhVYEo7w7EiGzNMG+mz0541oyCs+u/AWeX3p68ilQnrK3UT?=
 =?us-ascii?Q?SI2W8ApysuAXGH4rZxKB6i0GMNxsDAkKwvNbfQEChMYmwAUfMh45845hEdqs?=
 =?us-ascii?Q?76twSf+nV7CzJS8L+0I1TtruM0ZhSbD2CZX/ds6nxdzmXO2BYhJm7cOb2zZ2?=
 =?us-ascii?Q?mr7mlp8u4Ed+WPpD5VdubwzkzvFJ30DxOWwN3R5Eo2ar4Z/PnZGC/l200zza?=
 =?us-ascii?Q?IjgiPpDo1RzqqR8+B1bm770TIbrrAnt2uyPSkir0Y9FqQUWX5c/hAN0vc68U?=
 =?us-ascii?Q?Z92wIWp8lY4sEcpp6RI6FfTQaCnhooCBk4QsCQlIVzsRxMsKsHsgsAvzwVvc?=
 =?us-ascii?Q?9tNg+H3Edn1hjAfE0Ry9E66+mZC6lJbQmUyYxd6RmMXpzvEhlh3W50WoNVML?=
 =?us-ascii?Q?cr/qCJMmVtyHRDsImaEuyUHunsOdwt0dfMBnQRHRF27BWxF2cxT0A5yybOYh?=
 =?us-ascii?Q?Lol1+fHbWeG+eimC0dw0xVZMOmxF5qE8hp8hrXOSl9Ms+n18K+3Ksi4U9KF4?=
 =?us-ascii?Q?w2z+9gi9iesDtLUKNf4j9E71GOOwCNr0GVIHC6a1dDe2hPNCa2ovxtbyYDNK?=
 =?us-ascii?Q?zaqrLZu8qRiJ9XHkUH2dPZlNpEe9Xcunn/wqv6pya+s8cHLU/gyquvpSmGbl?=
 =?us-ascii?Q?HhV1Bv8nuLKYmh+NIrO2GSkXbXxF1Z2PEbQWdffxUceI1zY+qsFZfF+oHT7d?=
 =?us-ascii?Q?95BWTgB8dozVpolmDv9dvtVbJw/geANEF6KTHvOUqQ9G3jIyd/18GMPa/AOq?=
 =?us-ascii?Q?CCIBcIq/3982GBQrDXyCU3xznqxAZfdvZZJLiQuBiZSpS3yW8t/U7K8h13Tf?=
 =?us-ascii?Q?F9tP2qm67aGLqAjz4u7WyA88Mg/hUM1E1M3hxz4EHj+Hd2QJokKanamN4tEA?=
 =?us-ascii?Q?3926Ui7Kvw++OFNq25hndpF7CvIfasm/za+ySBunRw9hr+JFB4Szv6XjHanI?=
 =?us-ascii?Q?zqtTjZSko1sPk7fYKr3w2xxyvhZiDg/u8apqBchrBZyTpblTeeyHs0D+KVo+?=
 =?us-ascii?Q?xc//urcuNRXX5wRRQbEKSwKOicbVHtB7U5kA3BONi4pl+Z2vPkWSdW7XVXrB?=
 =?us-ascii?Q?6kDNcTWdLmAQRkWUvdGlhGqCLx/H0veUP6ZvTA+YZhERdKfk+MVeoiEHYiXF?=
 =?us-ascii?Q?w9FYMYL7dMBHSs9b/nVnJz2UV9Qk3AsCIEg6kqgI+iH2NnLYm8Pah7QXiCGe?=
 =?us-ascii?Q?/NdelylbPOj0uzfnsbdaBV8swD8j7FwqOey0O/J2p0QfkFEFgPXy0DmPulnM?=
 =?us-ascii?Q?fm9d+TAo/J3tCafmKKqDPMfOnd7mwxYY6NCDoePmAarO6xlIKODIaoiH+1ie?=
 =?us-ascii?Q?eO1Txiyl41f2RoWG9tDVWTVj1t67bc7dVJu0qAY6Uj84aPrItklyvUoQ/8Dr?=
 =?us-ascii?Q?6UjQv2skPTuqwtAYbGD+eMQ5vY4uba0iCaYm87Nu47YReVwq3YQGOJ4ovPFw?=
 =?us-ascii?Q?ybzOerMg/EsgWqM7jfx8SWYfx+3avyfD46vkIZZFhtd8uYf4qLagAy47G4WW?=
 =?us-ascii?Q?60GWeW6bNOewzrgdRcdNq35WMmrXFm1x0phkWgPdOJDJZ/gmfGuix/u36AfC?=
 =?us-ascii?Q?TkTbpeUIhAS2HFX276pqrMpxydwNLaIWTSxR/hkKky5Z75gEm7xCTc2WUJFs?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59241C9B7CDFE747B7934CAB71ACB94F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678042db-16c6-4f82-5d8a-08daa6127d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 14:12:36.6305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2f0LGndEOQcPnlYZlxQu5AaGBLtiKpD82da0CBVJg1NfU88djxxvxxKSuxa3DCHuB6cfBKiuZCcfJh4DxkYiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040092
X-Proofpoint-GUID: MmgVUVGu16hyv0yy4EH1Z7-gpQlH0ZqC
X-Proofpoint-ORIG-GUID: MmgVUVGu16hyv0yy4EH1Z7-gpQlH0ZqC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 4, 2022, at 1:14 AM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> Hi,
> I have a customer who experienced a crash in nfsd which appears to be
> related to delegation return.  I cannot completely rule-out
>  Commit 548ec0805c39 ("nfsd: fix use-after-free due to delegation race")
> as the kernel being used didn't have that commit, but the symptoms are
> quite different, and while exploring I found, I think, a different
> race.  This new race doesn't obviously address all the symptoms, but
> maybe it does...
>=20
> The symptoms were:
>  1/   WARN_ON(!unhash_delegation_locked(dp));
>    in nfs4_laundromat complained (delegation wasn't hashed!)
>  2/   refcount_t: saturated; leaking memory
>    This came from the refcount_inc in revoke_delegation() called from
>    nfs4_laundromat(), a few lines below the above warning
>  3/ BUG: kernel NULL pointer dereference, address: 0000000000000028
>     This is from the destroy_unhashed_deleg() call at the end of
>     that same revoke_delegation() call, which calls
>     nfs4_unlock_deleg_lease() and passes fp->fi_deleg_file, which is
>     NULL (!!!), to vfs_setlease().
>  These three happened in a 200usec window.
>=20
> What I imagine might be happening is that the nfsd_break_deleg_cb()
> callback is called after destroy_delegation() has unhashed the deleg,
> but before destroy_unhashed_delegation() gets called.
>=20
> If nfsd_break_deleg_cb() is called before the unhash - and particularly
> if nfsd_break_one_deleg()->nfsd4_run_cb() is called before, then the
> unhash will disconnect the delegation from the recall list, and no
> harm can be done.
> Once vfs_setlease(F_UNLCK) is called, the callback can no longer be
> called, so again no harm is possible.
>=20
> Between these two is a race window.  The delegation can be put on the
> recall list, but the deleg will be unhashed and put_deleg_file() will
> have set fi_deleg_file to NULL - resulting in first WARNING and the
> BUG.

That seems plausible. I've been accepting defensive patches like
what you proposed below, so I can queue that up for v6.2 as soon as
you post an official version.

It would help to know the kernel version where you encountered
these symptoms, and to have a rough description of the workload;
I assume you do not have a reliable reproducer. I'm wondering if
there should be a bug report too (bugzilla.linux-nfs.org)?


> I cannot see how the refcount_t warning can be generated ...  so maybe
> I've missed something.

stid refcounting does not seem reliable in the current code base.
It's possible that the overflow is a separate issue that simply
appeared at the same time or due to the same conditions that
triggered the BUG.


> My proposed solution is to test delegation_hashed() while holding
> fp->fi_lock in nfsd_break_deleg_cb().  If the delegation is locked, we
> can safely schedule the recall.  If it isn't, then the lease is about
> to be unlocked and there is no need to schedule anything.
>=20
> I don't know this code at all well, so I thought it safest to ask for
> comments before posting a proper patch.
> I'm particularly curious to know if anyone has ideas about the refcount
> overflow.  Corruption is unlikely as the deleg looked mostly OK and the
> memory has been freed, but not reallocated (though it is possible it
> was freed, reallocated, and freed again).
> This wasn't a refcount_inc on a zero refcount - that gives a different
> error.  I don't know what the refcount value was, it has already been
> changed to the 'saturated' value - 0xc0000000.
>=20
> Thanks,
> NeilBrown
>=20
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c5d199d7e6b4..e02d638df6be 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4822,8 +4822,10 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> 	fl->fl_break_time =3D 0;
>=20
> 	spin_lock(&fp->fi_lock);
> -	fp->fi_had_conflict =3D true;
> -	nfsd_break_one_deleg(dp);
> +	if (delegation_hashed(dp)) {
> +		fp->fi_had_conflict =3D true;
> +		nfsd_break_one_deleg(dp);
> +	}
> 	spin_unlock(&fp->fi_lock);
> 	return ret;
> }
>=20
>=20

--
Chuck Lever




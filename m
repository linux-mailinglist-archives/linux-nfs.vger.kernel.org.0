Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5186FC908
	for <lists+linux-nfs@lfdr.de>; Tue,  9 May 2023 16:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbjEIObT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 May 2023 10:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjEIObS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 May 2023 10:31:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4028A10E4
        for <linux-nfs@vger.kernel.org>; Tue,  9 May 2023 07:31:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349E1rcw028952;
        Tue, 9 May 2023 14:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=E+aqKGdcPZ9iuYy/66twQLCgedqehtm6BFMHWPEUDyE=;
 b=mUHWpsPDM1yVVKIQ1EetalpxV0cFcfAHkTApQVWztQRShTNQSRIem58tqOEY/vHd8dfl
 PzhLONeVHK8f3Y8LHdK7djacJ4D/ZPx+y9kKgeM5vk0eBeMi118vpThSZkfiPrWjqbPt
 n8VyU5kc+audyFBmqoxTrOI2ZC4j8F6S9xJmm6YRG0s8xRp0G3davnRzXAoS67L3OAVH
 uhkPDkGzsef8PuYv8s8jdAzvBn7R4Zi3A8yFENChnqb6Dw0Z/jTouf0pRLfIzLW5b+2n
 lx54Ir9a8XDYj4n38bSIOtxwluJcGYS/lkzu7FyjwAQGqJxTVuIQT1EwNZK1wdtuJLQU uA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf776hxeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 14:31:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 349ER9Ct005790;
        Tue, 9 May 2023 14:31:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7ph9fnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 14:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp/9GSxYXM09Pn8PIe1K3VXAyS8uJNxSnyaACQjIdcKjlztwc48jXEKIlUwvCrOZNxJYlVWv2kqvyfWuS1sZRteVCEnU0H7oaymDpQPmznVa4f5abe+RNDGdIlRIN91EsiGjUlNPN8JcwoNpctLgdh7dknrkTz2yRwl1XSl1qUZBWzcUXNSJWn0Vg6U8/UepHJLXE+NREswql6VcwNrtrwYo0q2G1c2tzityk2guHxXV+ZuC1WMIbbO6oiff1V8XGI5B1hn7HBfidV6ipfm6KR1c09aJ4A8gbKSYxwgFROjrT2twerApNfaDDEBoKxUYwVx/Fvs+YIt1MilX5PU97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+aqKGdcPZ9iuYy/66twQLCgedqehtm6BFMHWPEUDyE=;
 b=CjEaN1hJtrrZpDP08O2nuPtujSXxJ7LI9vM35lVVOi0NH2dmqC2xapIS7VNv6NTZg1F/h57JxHeObVhljchgLjDWU+eTqWMspX6gb0wjqe5XNcrsF1h0D1J7UvntBZLVRKhniFxO5KbkxSPzpxxKgHejArhQyMihujqs5Iub90Cc2+e2WgvX7RNJkan96kj3lXLEzFH5RJ/jPwV7vAep7Yq6/gVnMTkBBe2+iff8PQyQy0llKuDvoZ4zK21V7HNInE3YSf2CymU2e8BzTg8736qiN2Fc+4u4ANuV9o/h/J4yxm62M+ExGrbajsbEgNTGctn1Qel7Xg8CF6W1F5gGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+aqKGdcPZ9iuYy/66twQLCgedqehtm6BFMHWPEUDyE=;
 b=XwK+fyFMhW6h6FGyUg6vH1lT0HWxpBkWwQp3YFLfxqzhY0ofO1LkE8L27US8RrQ4hx9y9HZECV7vAhHTb16Ot/JVwpQ8oIDyPxiSSjGrlvLmwuYfN08oBq05MWhduyNYwFyddTNFxq/54azNxsZ8G7R/GlC/xmBgMuCtqwa9zHw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7107.namprd10.prod.outlook.com (2603:10b6:510:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 14:31:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 14:31:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] SUNRPC: always free ctxt when freeing deferred
 request
Thread-Topic: [PATCH 2/2] SUNRPC: always free ctxt when freeing deferred
 request
Thread-Index: AQHZggbSR2P+aHrVcUi5XDnSgen4iK9SAaeA
Date:   Tue, 9 May 2023 14:31:02 +0000
Message-ID: <4E866BCD-D7FE-44D9-B98A-A4BBC8C4C7DE@oracle.com>
References: <168358930939.26026.4067210924697967164@noble.neil.brown.name>
 <168358936786.26026.624483381722608538@noble.neil.brown.name>
In-Reply-To: <168358936786.26026.624483381722608538@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB7107:EE_
x-ms-office365-filtering-correlation-id: 06408b3f-3762-4863-ff11-08db509a03b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xmXIoJhMKzR5uF9yFUQEJsi722SGchVcP4ia5PN7ppGua2lvthJd/fhmNMevV57CYzpv7xfjlzoch31qQfSRATzVq2Mp39fPWlR/1Uf+kA6BNkAgr3p3GOEa1CZNEae4JKeZ46vP8poaIsaNdIMpqjykdo/26IETglxQLSqsEL5APBB29ccy28DwURiqvmX6KUujUPzLEZvFEvKQGDALAneBGW8oyLatUYFH/rMuiHxnPR/up/Afeq9HIlioyHLe/TxOBcYbQefkYdN2br6wGPY6Jc1aouC2WAYFjlhlFiYqGrV+TjYbJHiU6jBhYwTvdrlf3b1yOYX23HV0A8Kwg4xoi5fWX3esc5gNId2h/JUSDZgmYJ0DPa5Ts8La5bUrnrbkzdHAVycHRHshV/wgRqW05sDTo8wfKKECHVWlBQSCiUyGndbIBclzq42conCuo5EYeqCqxQqXpkDrEYwmwRvCF2Fy7+c7033gdPIv0kDHR298vNTJJa0NXKKEgSSvA6M3Qlt72DfnLPjGJgKdwYkpPRsgkMW+r5GtWRn7nzBGC20mB5YXBnK+NuWq+dmY0PZtSHTRC6gRncgG/2DKe24a7hMhBFiLtKM1yfasMi/66rGr12guz432CiKb3occ4L5CmIfTV2CG/eXYDDYVWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(33656002)(38100700002)(83380400001)(54906003)(38070700005)(316002)(53546011)(122000001)(6506007)(41300700001)(6512007)(26005)(8676002)(5660300002)(8936002)(6916009)(4326008)(91956017)(64756008)(66476007)(66556008)(76116006)(66946007)(66446008)(86362001)(186003)(2616005)(478600001)(2906002)(36756003)(71200400001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mikZIvz1NVxdaOOda0Pr6y3Yik15PDHDO744VeuLguShpIy4cE97nbCIQcPX?=
 =?us-ascii?Q?58lrwzyOge5PMSzXisvEGpRv5tE4vp7cFF2lP4XEbQPQYRZAZgnd5aoRk62R?=
 =?us-ascii?Q?9/GNIlhipqo596+HAZu7+5TBNRlg97rVkltF9nvn7Uvih6NtMfZWc70+H5bq?=
 =?us-ascii?Q?1UuIaK1BNuNZYCVK15xRI5mkl+oVayNgByu87L4NA+aMss3KPkTrK2lo9nD7?=
 =?us-ascii?Q?fa3wXxoHryL9qVO2wtXUCkyRbxPS1y+TWvH7cCtMw0dezaduZsv8ScHYIkl5?=
 =?us-ascii?Q?wIxrkHfoLB22On9dhRTO5DO7abTEf6sE7iHuBvv96ITUIeesbjltQ1aotYEz?=
 =?us-ascii?Q?wNism/GG0LIpnxL1Rm1PYcOvfMnIGVtj53s77fnZIglDHK4gIyn7LcX3xqSB?=
 =?us-ascii?Q?D7ViTePZ8xiqTThCdRe7Df1exdjeu3cZO+jUwDwakEWXiK+qGws9sq715TYS?=
 =?us-ascii?Q?0wJsWwRkdep1UT/mCApeJeg7/N6ILIFC+tTTDTT2aRQdwBnqycZYsNOPdE+7?=
 =?us-ascii?Q?+epBU9MbAyRC+sD2CkYm/bKvEth1wTv9RnkbESMZqGPLGaZEBhsHz4Ny/b3G?=
 =?us-ascii?Q?oU04ra3XRicK8Xd4lqj3D8JANZs5dtikrjjfR+wgL0j+vOecYx70fbtEVD0t?=
 =?us-ascii?Q?R4+9oYcQyT5t6b6097FuxXv69iuiL7qeeTjWEtDmKGOKeIH1GK1igqgZ3Ttk?=
 =?us-ascii?Q?r1Gu5qKIKn72PlGhQjmQVK+xZAdGL1I012VW5aJgXREJQcIhBI4R3JQyWsY/?=
 =?us-ascii?Q?tkRGHrCEijnOSo+8/W5v1NzrhkfwLwz3Fca+O+Z6/qiw33irKb05YKKLanlk?=
 =?us-ascii?Q?L1YTKi1fu5E8BAM8oJ7dxl7GMtieZ6glLOsDqYka6OOJmwSjA46gDlfF51sY?=
 =?us-ascii?Q?jyk2qgo4uQ8Q2/9lKzwWehcGSnJpwCO/O2tXlOzLFMyzfKYsHT5zUsnp4c92?=
 =?us-ascii?Q?bPUOpmf071RcaeeodytpJAURCyZRgP8svjIP9+/NNe4XqSYr/0yQAW5/35qX?=
 =?us-ascii?Q?Vp9qv6ZsLsiK9p4MuBOxmHSqdsdiavgdBg0gYfec2P3km4nFcHmM9YKxR6wH?=
 =?us-ascii?Q?LSC/me9d3UrPbvCF/0NGf7/8K6SaTi5g3V88c49n0IcHO4RvBDOyZdTZA5R6?=
 =?us-ascii?Q?MsOUaVWOVTv4XjbUVB6S9+vHeoK3Gvtz6qi2zjBbTo7EJ47wvH61jN/6LGrN?=
 =?us-ascii?Q?0HUi+1N7sBe8C1utdIH4lmWPOU46zhTB5MhVHypLRJiePaRx3pYuBKx/fbnL?=
 =?us-ascii?Q?37LWn+/ZiPZdruMGek3BdH40d6yS1itLssivdz97pDYYvagjPcyuFJCeLioW?=
 =?us-ascii?Q?yVFPzPV4zZPbUEF1vcHYMZ8xnD9UtRBQZIiKCpgOR2ZICagvIrKzypMvRKwB?=
 =?us-ascii?Q?yJwSsVF663zQorPn19xHESzQDOTzz3WqUaaUyihmTyG0vFdtgrE5sSFVidOc?=
 =?us-ascii?Q?QThkiL6kA1JZlT6UbNp0AZVKkiE2CegngzNoiV63hT0FhGqc644wYIaNPTm0?=
 =?us-ascii?Q?V/2nCYZmjLqovRY25AvvadOvsnVK/gy8Z7H/3aMZAL8iLiWpKRgPVxABsm5L?=
 =?us-ascii?Q?9jXVdh8QZ0aEOFrgXxZzLraGQ2HlEqPdbuxgYWmeK2Am69E+bhn8z83TBMEq?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0E7BC5CF995304BA49528F690483791@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9SBIfzV2FNLxe5h1N+/Z1dIyNpU7lGCp5AnXZg0FHkfsWuZo5yor/jqM1+AP6+fLbj0ZOkC8K3Uz5wTnpeaN1Rhg+fZJREhZQ4m6uebdkd0Npu6U51HcLqtaRmEar4j+MKh4U6BNvBvwMEQE4UGbxOWdUlhmW5WRjWAA0RaMHAwm2ec7b49IP6bxGZuQyVrP4B7ZCtd2m7NIlG6nV60ECp6FYMn2KuNXqDRE8etVHAUGnRI3PJclphibVL7AREEnE0Q8mXlzTR+6JdZ4uSBtH01A5pHsbnb4JIx5P6p/ui3uJkBzPf2jQPDoLqtOYOaqJTrGHUtpsbO3A6qC8CT/asG+7hDt4vW50wYmFGBojfQoeWJAo310xTAf+saHqYq/rAD2jZ+gfTM/qCBPHUsVkRpbA3vRLOhDSXDgy3SZCvGg7VzbrpgBPZAq99vXcVcdLnWS73OakQXJc26vd8qWD04fMwVvs0CDCsIGTNRxPcUxnPBIvoY7405JEob3ccuOafiE9CSp0ybdDm6V6IcujksrrX3FPYxkboGD4IAMF9rc3+2IpnyNy/kdCwbjHOB72CdqiURymAehC2/7XxUWR+CpZ2UBUbckgEwaquWff06KPWednBWrm6AjR8i3TFywssSRxDp229/lYrPSBOKzaE/gmZt76cpmxdX3E51T8IaFEWHmdCCFVZJNAHzrLAvuVfe5JBemw1wfVKOf1mraas7Vsa+ch9sHwh4VOBBvTALHpmdHVtp5Fw/yXJdq00sgEOW5bdeanfD1QWXbffVowE8tOKQyH/W5NIKrRzsr7mx/ebMydV2sp76NXXQ8hAsp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06408b3f-3762-4863-ff11-08db509a03b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 14:31:02.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NINdKSVPCIfv8D28sW9u42PfsIwl4xTL5xV/5k+HPBZnpPFlCvV+89ZGNVXPyr4GNgCPZyLJKAd+/c9ex2TMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090119
X-Proofpoint-ORIG-GUID: YmyIMoRHNnSKJJmMibVk_BvY-KWO-a7Q
X-Proofpoint-GUID: YmyIMoRHNnSKJJmMibVk_BvY-KWO-a7Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 8, 2023, at 4:42 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> Since the ->xprt_ctxt pointer was added to svc_deferred_req, it has not
> been sufficient to use kfree() to free a deferred request.  We may need
> to free the ctxt as well.
>=20
> As freeing the ctxt is all that ->xpo_release_rqst() does, we repurpose
> it to explicit do that even when the ctxt is not stored in an rqst.
> So we now have ->xpo_release_ctxt() which is given an xprt and a ctxt,
> which may have been taken either from an rqst or from a dreq.  The
> caller is now responsible for clearing that pointer after the call to
> ->xpo_release_ctxt.
>=20
> We also clear dr->xprt_ctxt when the ctxt is moved into a new rqst when
> revisiting a deferred request.  This ensures there is only one pointer
> to the ctxt, so the risk of double freeing in future is reduced.  The
> new code in svc_xprt_release which releases both the ctxt and any
> rq_deferred depends on this.
>=20
> Fixes: 773f91b2cf3f ("SUNRPC: Fix NFSD's request deferral on RDMA transpo=
rts")
> Signed-off-by: NeilBrown <neilb@suse.de>

I haven't yet looked closely at these, but they look clean
and sensible at first glance. I'll apply them to nfsd-fixes
with Jeff's suggestion and Reviewed-by.


> ---
> include/linux/sunrpc/svc_rdma.h          |  2 +-
> include/linux/sunrpc/svc_xprt.h          |  2 +-
> net/sunrpc/svc_xprt.c                    | 21 ++++++++++++-----
> net/sunrpc/svcsock.c                     | 30 +++++++++++++-----------
> net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 11 ++++-----
> net/sunrpc/xprtrdma/svc_rdma_transport.c |  2 +-
> 6 files changed, 39 insertions(+), 29 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_r=
dma.h
> index 24aa159d29a7..fbc4bd423b35 100644
> --- a/include/linux/sunrpc/svc_rdma.h
> +++ b/include/linux/sunrpc/svc_rdma.h
> @@ -176,7 +176,7 @@ extern struct svc_rdma_recv_ctxt *
> extern void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
>   struct svc_rdma_recv_ctxt *ctxt);
> extern void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma);
> -extern void svc_rdma_release_rqst(struct svc_rqst *rqstp);
> +extern void svc_rdma_release_ctxt(struct svc_xprt *xprt, void *ctxt);
> extern int svc_rdma_recvfrom(struct svc_rqst *);
>=20
> /* svc_rdma_rw.c */
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_x=
prt.h
> index 867479204840..6f4473ee68e1 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -23,7 +23,7 @@ struct svc_xprt_ops {
> int (*xpo_sendto)(struct svc_rqst *);
> int (*xpo_result_payload)(struct svc_rqst *, unsigned int,
>      unsigned int);
> - void (*xpo_release_rqst)(struct svc_rqst *);
> + void (*xpo_release_ctxt)(struct svc_xprt *, void *);
> void (*xpo_detach)(struct svc_xprt *);
> void (*xpo_free)(struct svc_xprt *);
> void (*xpo_kill_temp_xprt)(struct svc_xprt *);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 5fd94f6bdc75..1e3bba433561 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -532,13 +532,21 @@ void svc_reserve(struct svc_rqst *rqstp, int space)
> }
> EXPORT_SYMBOL_GPL(svc_reserve);
>=20
> +static void free_deferred(struct svc_xprt *xprt, struct svc_deferred_req=
 *dr)
> +{
> + if (dr)
> + xprt->xpt_ops->xpo_release_ctxt(xprt, dr->xprt_ctxt);
> + kfree(dr);
> +}
> +
> static void svc_xprt_release(struct svc_rqst *rqstp)
> {
> struct svc_xprt *xprt =3D rqstp->rq_xprt;
>=20
> - xprt->xpt_ops->xpo_release_rqst(rqstp);
> + xprt->xpt_ops->xpo_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
> + rqstp->rq_xprt_ctxt =3D NULL;
>=20
> - kfree(rqstp->rq_deferred);
> + free_deferred(xprt, rqstp->rq_deferred);
> rqstp->rq_deferred =3D NULL;
>=20
> svc_rqst_release_pages(rqstp);
> @@ -1054,7 +1062,7 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
> spin_unlock_bh(&serv->sv_lock);
>=20
> while ((dr =3D svc_deferred_dequeue(xprt)) !=3D NULL)
> - kfree(dr);
> + free_deferred(xprt, dr);
>=20
> call_xpt_users(xprt);
> svc_xprt_put(xprt);
> @@ -1176,8 +1184,8 @@ static void svc_revisit(struct cache_deferred_req *=
dreq, int too_many)
> if (too_many || test_bit(XPT_DEAD, &xprt->xpt_flags)) {
> spin_unlock(&xprt->xpt_lock);
> trace_svc_defer_drop(dr);
> + free_deferred(xprt, dr);
> svc_xprt_put(xprt);
> - kfree(dr);
> return;
> }
> dr->xprt =3D NULL;
> @@ -1222,14 +1230,13 @@ static struct cache_deferred_req *svc_defer(struc=
t cache_req *req)
> dr->addrlen =3D rqstp->rq_addrlen;
> dr->daddr =3D rqstp->rq_daddr;
> dr->argslen =3D rqstp->rq_arg.len >> 2;
> - dr->xprt_ctxt =3D rqstp->rq_xprt_ctxt;
>=20
> /* back up head to the start of the buffer and copy */
> skip =3D rqstp->rq_arg.len - rqstp->rq_arg.head[0].iov_len;
> memcpy(dr->args, rqstp->rq_arg.head[0].iov_base - skip,
>       dr->argslen << 2);
> }
> - WARN_ON_ONCE(rqstp->rq_xprt_ctxt !=3D dr->xprt_ctxt);
> + dr->xprt_ctxt =3D rqstp->rq_xprt_ctxt;
> rqstp->rq_xprt_ctxt =3D NULL;
> trace_svc_defer(rqstp);
> svc_xprt_get(rqstp->rq_xprt);
> @@ -1263,6 +1270,8 @@ static noinline int svc_deferred_recv(struct svc_rq=
st *rqstp)
> rqstp->rq_daddr       =3D dr->daddr;
> rqstp->rq_respages    =3D rqstp->rq_pages;
> rqstp->rq_xprt_ctxt   =3D dr->xprt_ctxt;
> +
> + dr->xprt_ctxt =3D NULL;
> svc_xprt_received(rqstp->rq_xprt);
> return dr->argslen << 2;
> }
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index a51c9b989d58..aa4f31a770e3 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -121,27 +121,27 @@ static void svc_reclassify_socket(struct socket *so=
ck)
> #endif
>=20
> /**
> - * svc_tcp_release_rqst - Release transport-related resources
> - * @rqstp: request structure with resources to be released
> + * svc_tcp_release_ctxt - Release transport-related resources
> + * @xprt: the transport which owned the context
> + * @ctxt: the context from rqstp->rq_xprt_ctxt or dr->xprt_ctxt
>  *
>  */
> -static void svc_tcp_release_rqst(struct svc_rqst *rqstp)
> +static void svc_tcp_release_ctxt(struct svc_xprt *xprt, void *ctxt)
> {
> }
>=20
> /**
> - * svc_udp_release_rqst - Release transport-related resources
> - * @rqstp: request structure with resources to be released
> + * svc_udp_release_ctxt - Release transport-related resources
> + * @xprt: the transport which owned the context
> + * @ctxt: the context from rqstp->rq_xprt_ctxt or dr->xprt_ctxt
>  *
>  */
> -static void svc_udp_release_rqst(struct svc_rqst *rqstp)
> +static void svc_udp_release_ctxt(struct svc_xprt *xprt, void *ctxt)
> {
> - struct sk_buff *skb =3D rqstp->rq_xprt_ctxt;
> + struct sk_buff *skb =3D ctxt;
>=20
> - if (skb) {
> - rqstp->rq_xprt_ctxt =3D NULL;
> + if (skb)
> consume_skb(skb);
> - }
> }
>=20
> union svc_pktinfo_u {
> @@ -696,7 +696,8 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
> unsigned int sent;
> int err;
>=20
> - svc_udp_release_rqst(rqstp);
> + svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
> + rqstp->rq_xprt_ctxt =3D NULL;
>=20
> svc_set_cmsg_data(rqstp, cmh);
>=20
> @@ -768,7 +769,7 @@ static const struct svc_xprt_ops svc_udp_ops =3D {
> .xpo_recvfrom =3D svc_udp_recvfrom,
> .xpo_sendto =3D svc_udp_sendto,
> .xpo_result_payload =3D svc_sock_result_payload,
> - .xpo_release_rqst =3D svc_udp_release_rqst,
> + .xpo_release_ctxt =3D svc_udp_release_ctxt,
> .xpo_detach =3D svc_sock_detach,
> .xpo_free =3D svc_sock_free,
> .xpo_has_wspace =3D svc_udp_has_wspace,
> @@ -1298,7 +1299,8 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
> unsigned int sent;
> int err;
>=20
> - svc_tcp_release_rqst(rqstp);
> + svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
> + rqstp->rq_xprt_ctxt =3D NULL;
>=20
> atomic_inc(&svsk->sk_sendqlen);
> mutex_lock(&xprt->xpt_mutex);
> @@ -1343,7 +1345,7 @@ static const struct svc_xprt_ops svc_tcp_ops =3D {
> .xpo_recvfrom =3D svc_tcp_recvfrom,
> .xpo_sendto =3D svc_tcp_sendto,
> .xpo_result_payload =3D svc_sock_result_payload,
> - .xpo_release_rqst =3D svc_tcp_release_rqst,
> + .xpo_release_ctxt =3D svc_tcp_release_ctxt,
> .xpo_detach =3D svc_tcp_sock_detach,
> .xpo_free =3D svc_sock_free,
> .xpo_has_wspace =3D svc_tcp_has_wspace,
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdm=
a/svc_rdma_recvfrom.c
> index 1c658fa43063..5c51e28b3111 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -239,21 +239,20 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rd=
ma,
> }
>=20
> /**
> - * svc_rdma_release_rqst - Release transport-specific per-rqst resources
> - * @rqstp: svc_rqst being released
> + * svc_rdma_release_ctxt - Release transport-specific per-rqst resources
> + * @xprt: the transport which owned the context
> + * @ctxt: the context from rqstp->rq_xprt_ctxt or dr->xprt_ctxt
>  *
>  * Ensure that the recv_ctxt is released whether or not a Reply
>  * was sent. For example, the client could close the connection,
>  * or svc_process could drop an RPC, before the Reply is sent.
>  */
> -void svc_rdma_release_rqst(struct svc_rqst *rqstp)
> +void svc_rdma_release_ctxt(struct svc_xprt *xprt, void *vctxt)
> {
> - struct svc_rdma_recv_ctxt *ctxt =3D rqstp->rq_xprt_ctxt;
> - struct svc_xprt *xprt =3D rqstp->rq_xprt;
> + struct svc_rdma_recv_ctxt *ctxt =3D vctxt;
> struct svcxprt_rdma *rdma =3D
> container_of(xprt, struct svcxprt_rdma, sc_xprt);
>=20
> - rqstp->rq_xprt_ctxt =3D NULL;
> if (ctxt)
> svc_rdma_recv_ctxt_put(rdma, ctxt);
> }
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrd=
ma/svc_rdma_transport.c
> index 416b298f74dd..ca04f7a6a085 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -80,7 +80,7 @@ static const struct svc_xprt_ops svc_rdma_ops =3D {
> .xpo_recvfrom =3D svc_rdma_recvfrom,
> .xpo_sendto =3D svc_rdma_sendto,
> .xpo_result_payload =3D svc_rdma_result_payload,
> - .xpo_release_rqst =3D svc_rdma_release_rqst,
> + .xpo_release_ctxt =3D svc_rdma_release_ctxt,
> .xpo_detach =3D svc_rdma_detach,
> .xpo_free =3D svc_rdma_free,
> .xpo_has_wspace =3D svc_rdma_has_wspace,
> --=20
> 2.40.1
>=20

--
Chuck Lever



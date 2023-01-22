Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47AA677380
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jan 2023 00:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjAVXkj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Jan 2023 18:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjAVXki (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Jan 2023 18:40:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0E78A59;
        Sun, 22 Jan 2023 15:40:37 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30MMoi6d032441;
        Sun, 22 Jan 2023 23:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=R8U3Hw2hZsaa9hJy8xqcKPkCMmb4yjhC9Pbt8/2TGBk=;
 b=m0bgqT8rOWu6y+Co58c3xcCYhL1J/sXfn4lUt/c2i+0yD/es42QkyR3nnQiXSce65fza
 P0TO2RIAoDIsXChNzwgzmDJvjmx2V5p3wXV6FceyfROJyMIokE6ZDERGQFDE4q4IjUDZ
 dDX9kPsI/ziE3/uIgQ+9+GUoR4Fwf8Mgz9sNWySJxxTRTrYXy7cx/HoPKbaPxP7iFanj
 LdGYjnpHBTbItkGOR0rt22py4q6lW3mGFyin+3Aqs5xJ826sSkF5IS4i8QV+CpUTWYdc
 nG5yRY5wDrE51eyDFwrAscxZrTsRdrS94geYAXdRmu6fpW9un62i3TxmYXEL6pkkGOaZ Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87xa1pd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jan 2023 23:40:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30MM5THN034219;
        Sun, 22 Jan 2023 23:40:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g2vc2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Jan 2023 23:40:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThnSq72SojkV03AdEX1MQacce978+i2vshENP8oRBfhicxaVX5Rg/qYmApThEEv7xq2tM5SFWzwOTg+tujWsHo+HWNTtmFl3xZl88uo3FQmKsht5y7IoutzAeq5dsuhbaMhV0Q05go9db2z+xrVWFgEEUt3XZgtPPym5/WDV2JE4XjhUPethAoSRWr9Km92e5PxD5N+tmacpyB1Hs5JrEbZhsTTUaRtbIxFmJQQkWZiy38p2j84XIxn23aFtdkWm6dZgtmcQEJd+tw2un+U8UAyrgfkTjmMaTNZSp4/VwLCmKieQXQUdXOffdVxyGcIe1TPy03rG8C7Hj1buZPerfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8U3Hw2hZsaa9hJy8xqcKPkCMmb4yjhC9Pbt8/2TGBk=;
 b=HH7FlEeyXNlkR22z5nR/vuvJT7V0jL6wEqFGMRyKUqyLHc9Vkqc+URLNYdG0dfVM22T7McJz/erpetnKXckIdqgjRv8dW6RZZeHaAbzn68JJvzzV2TegP/C5In6rB+BG317GH/zUqYFm6q/sBwNs/3Cf9EilPOaJczuux36zaZ5T6M4wslHk3iYKivrb0/IQSr6H0Wrk2+kv645JvJEZoOSNMorjRlT61Np3gZEpO3BGEBlAOOIZ3qk1S+htN/1yY+q548WH1y/Wp4uRbxgksSXtRC8ycON90/2g0eLwkZilTy7Ad9KuFbJBqwd5+o2tLwoc51kr1hjUemwQ2MSShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8U3Hw2hZsaa9hJy8xqcKPkCMmb4yjhC9Pbt8/2TGBk=;
 b=c0VG8q8n0ZtPlI+UKIz7PqCBIzzFfE4RhvU2glQvU/72bPm07SW/991GF3kQXQmaaKGKTEnrvmuvbI/m3CdGt5gJlHc7cmQG8eIY5uOgkJY2T/f9FE+5W+UKwSR9wZNL0UI4NNXZ/0OwHtsuonGgsglIdEaxBUwQCKuQlh3WgOI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4626.namprd10.prod.outlook.com (2603:10b6:303:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.13; Sun, 22 Jan
 2023 23:40:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6043.014; Sun, 22 Jan 2023
 23:40:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Shachar Kagan <skagan@nvidia.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Ruben Vestergaard <rubenv@drcmr.dk>,
        Torkil Svensgaard <torkil@drcmr.dk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't free files unconditionally in
 __nfsd_file_cache_purge
Thread-Topic: [PATCH] nfsd: don't free files unconditionally in
 __nfsd_file_cache_purge
Thread-Index: AQHZLQi3y7Mea6cMiE2cfMbyen4b566nv26AgAAJSwCAAVH0gIAABJsAgAFqooCAAJHQAA==
Date:   Sun, 22 Jan 2023 23:40:25 +0000
Message-ID: <376AEBC5-AC52-424C-9DD0-A70BA73E7FE9@oracle.com>
References: <20230120195215.42243-1-jlayton@kernel.org>
 <C04F7C2C-848A-47C5-9C4E-9B9E5E82BAFF@oracle.com>
 <d5dc64435fb82f17e79ae20a370e90914a291ea9.camel@kernel.org>
 <3BB57727-27FC-4294-A5F8-FBD8E900D94D@oracle.com>
 <539c19a01e7f6d582d7ae2804977ef779b29d44b.camel@kernel.org>
 <MN2PR12MB4486882D01C0068FFAF9C841B9CB9@MN2PR12MB4486.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4486882D01C0068FFAF9C841B9CB9@MN2PR12MB4486.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4626:EE_
x-ms-office365-filtering-correlation-id: 30bc7750-9f73-4944-f224-08dafcd20957
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CoIvNW2nCNa4c4NU7K2zVtrayTLFAWLCzHUy4Xi9+j9Ip/px9dfH4CxxCqh/K1mVgGcbT2QiMGbudp5LvabvZquPr504GL51kxt533AHYECqKber4jo+/a9hplaNvT2U9n5F8XpHdOIWYe09nu3FYm4pkmaKrBkJbQOZQoFB/WSHKDF2DF8eylWGRFaxC75b+Ug7OV98oSj0UVd2uSjxPhPbISUvMamThC+vQMK7PVaqlrseY1eTegEZIFe+d/y3WkIE8Z7Po3UEToqhoLKd70/A3CZB0PYDRCbMctoibigi4h1fieYo6/OzdsNPwYQrEMoWg14Q/doz1Slie+qEBHex7GkLSjlujakFwp3Pg7GLlqR59GaY06yfEM2t+XB6GQqANADD8k7cNY9BMajt8uohxnNSiVIxDAFF1kKfG/EVzk/KP8ixBiLKvw9wqm4CtLlC+aXdn62+mFbX9IVgnHdBTxf0u9ku8hyVLGfMIlLHe96henc/BahwLM+0AMsZ6McF6LIz+yF9fAdkJiFtkB/g2oRe8MjZxURDP9/CTrURMGoQi5FiUCYjsrt3CZZWtSgMxTjx+8oO+1h3h3mV4asmzovegFbwOflJWHyZgyKV09p+BXrdbgclGhUmTpmD7n+0yJWBjpQya7i1y6+vRRc408xJ5mHbFn+NCKJxz17+MZn/73qlkVe67qt0XQ284/nrB6VsWaD+la5RO50phu2nCLBc3TjtYNcs7POxp/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(36756003)(54906003)(316002)(91956017)(86362001)(38070700005)(122000001)(33656002)(38100700002)(26005)(6512007)(186003)(2616005)(83380400001)(6506007)(53546011)(76116006)(66946007)(8676002)(5660300002)(4326008)(6916009)(66476007)(6486002)(478600001)(71200400001)(66556008)(8936002)(41300700001)(64756008)(66446008)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XWcofoQPAyWagPqsTOqp9+bk7sihxPt9WmcCGap7w7oJ1m07a0tqszRbw/vR?=
 =?us-ascii?Q?IvMLMNdmz+HMqHSjidOu5wdzgG3W7s4S2WX8tRseO6eMeMZe4qGnfXdPObJf?=
 =?us-ascii?Q?j7cf+f3EnSqqBuXE03iraYOw/ZFvuWFMZVcX0YS6PgS7ZAimKEJ10UhlHB9B?=
 =?us-ascii?Q?ov3ggLzDzMiyHA6I8ad0g5038SvU15r2BfQGnvoID2EwbhbHxkonsWr4H/+s?=
 =?us-ascii?Q?FS/yGD7he3Bh4RpcfE7TZ++vYcqSrLS4rBwrMaz5ZiVib1KAzE9PsRAjFil2?=
 =?us-ascii?Q?eJ5keejddB3XxW4ZJ4KVk1CyYjcDTP7d+y5Jv6fVzMJBX6K1+lQE9ffA47rb?=
 =?us-ascii?Q?DqUtDffuEFfZQyRXTe7AcYI0quuTSCKya22cCc9BB1bq3+tBJw1IJvUBIVvS?=
 =?us-ascii?Q?4whKMafzGQWA/GGljOcjyeJa7+A/rxYzDdu3AbO3Fe8dZrWaKV3JPd3b4nRe?=
 =?us-ascii?Q?Dcr0HVkmIR+g03eXAMxiijJzRGZPvJ/cJdBK5IkIA8USghOIC+RS43d7ZvJc?=
 =?us-ascii?Q?sBv4lROY8GFsxWapOSgHiEeD8HJmmp1DSejLDkikZ+w/QB4SPQc8gfqdmnlL?=
 =?us-ascii?Q?5FNOs3RQi0lpglJ2Oe6plwttNSeFd0XItBAmpor7AQINGMR1HZtCsVNgkAke?=
 =?us-ascii?Q?lMlaYNRyzrif2ZQHc7sYrvgdktGX6F+CQtSnkF/oe3ftuSIad/dPvVWsi5kn?=
 =?us-ascii?Q?T1GjoLicn4duDkL+O74qQC13+uq+D4aYRasgUBntPfvpzZz4+uGSnDbmkqj9?=
 =?us-ascii?Q?WYXd9mmonzAJLqcUsgMeNQSDNKeq6MsY2R+7Vn4mE905hB/97JNmmSpdcgff?=
 =?us-ascii?Q?Esdf+CMYXERkX3G9OhsPxKDjRV06AZycSQ6Ys3TL8W50v6BGDhmGyVe7bcgV?=
 =?us-ascii?Q?ppM9lHCy6dcZPmkGRhwHGlI4Siz/BeJbQ9zuODVGaETd8WXTuR1wMjOHOkYy?=
 =?us-ascii?Q?xl6YEKuCYncTXNvAN6A/PUDcDCZBnnHCmXiRD7VXKVP3kGzC7trqM4VWJXN/?=
 =?us-ascii?Q?SGJkk9ajlbBRgbk/1pVdwwcRRhMQZ0QYY5qSwUQ6QokqXsiVGrEW2gKYifaO?=
 =?us-ascii?Q?1IDkY6MjyC0IyjgN0fdUp2phXd+wQZTV45riHFTK5ngRvJkasjxIWoJcMdwR?=
 =?us-ascii?Q?TbLyXPlkdaKwpbjNmyQU/XIBchfn/uxKbd/cDv/5BafEYi3BC7WQTBL3VXBB?=
 =?us-ascii?Q?I68GZm2aaiaJYuVIeFZjBS6/F1F/vffzT8roYL00gSUKGMcrc1/qASL3NIZu?=
 =?us-ascii?Q?RzlwvpCS55WCmugpx05639yY2Q/C5vZppnn7K1pXF1umQBhoPbxTQwj7jjh5?=
 =?us-ascii?Q?iJpz28IYYbvI/afB1afXI5tOzB242D/7Czv0d9Manip3g+lvRDQZzTnTyPFB?=
 =?us-ascii?Q?peQ6THYlSYSrOq4sD4rzGPKrxfUiqELfWyzkx3T5Ay46WDJFQR3YOQaOA24E?=
 =?us-ascii?Q?OvB18klMB9/cmpehBVp993rLiH3mBqFdYJjagmbpLuwrKtCmG2rz0gi0TOjJ?=
 =?us-ascii?Q?h/pLekTZd0lXtOA7eVz/WwRA3VNDRiRVSWPkZZa9SwDIvGgM9XFyFN4a8XPp?=
 =?us-ascii?Q?Ab6zSN6YSz/42FtcjgMJDR+FpzvoyzXuB+wZHfHBKibSgrzG/xB2bpuXG6bb?=
 =?us-ascii?Q?uA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B78DD2E3FE75F4BA1A043A90EA191D4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nOhb2OvbScz220rdXZBACs5MoOsKbtgj2WjPFuf1ktJCx7/eQ3uJFB9rkKBDWVUMCO2oN8zERIOVMgyVt0FYvnkXZXq4Xzt55rlA4TUmnuIxOWfdEEkJbmaVX7Q+lHpt8xjPRY48Iy685z8Pb5W3yoef2Ewf0mCUtLhYt5ydzDxBlDOR0oEKJe8Cr6f0wGoTeBLWIV+twH/R+coNQR7hlTY2RdG7ZgAba0GxvybiuCbQ8QSO5D5rCv0NKbbisj6GLKi1tPFmd2QaQZwcClv9Godpt2m9IfdxLpl/yX4L3+bGTTbd3UJAxnLZpmnKVcfHPwi95wY82J6YsVBaj8jV/AnsMd/ud0YHdwKT2Z1jtwZMTatBlt7cKntCxczrBchqAHadjAna5p98/vAx7zDg0WmcDBoqhl5LjwZ96Z1OU9Up35rfbXHKV7gv+PNbs+3PPsDMCdfeLFqmK69+qIHXismE5N3zZcoxIOts7rNXJLEfqPZMpAHCt6UsLLaJKeQoDV0+CRbjopNvzc8wogiKNjSDvk8sv19iSUTqC5COr5QX8BDtwadh1hsyi1JB+yR4uLFwK5kTcxO6pRQd1DPMHGJjKa7AJSBXxJYVV8xFyS4xOotKpO1m86pXAxjc5ulxoz8gdTS8UGqgjvP4mJh29bs7eu4aqw6VhiJjpj9nAwWhsapg/0y4kR7l6zp591gJrcFI9CljnuolIN/6nT2djm+MfCleP8XzieKfKfVgBK74TCAKVbeetHLvxX4ZObNwgNM4cVH5eUbyH8MziBWqhtAO3oiJW0OcKdfxFBjcfKMxgKSxxYxvxu+zL2T/WnHaDMYiKljt85FNF59ubhLMmAE7pE0L+S6/pnjHnfVx2U0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bc7750-9f73-4944-f224-08dafcd20957
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2023 23:40:25.6280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxXJUONIOyJvV4dJN3gmd0evlBvjE9RdRpdwu9KY1N7FF8aEVPW0UnApY2M733FsVitf7N9LhiZwF5gdgBFCGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-22_18,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=863 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301220232
X-Proofpoint-GUID: 2nrwpiRxGREO0Jh4TuaUXkBw4Vv34OYM
X-Proofpoint-ORIG-GUID: 2nrwpiRxGREO0Jh4TuaUXkBw4Vv34OYM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 22, 2023, at 9:58 AM, Shachar Kagan <skagan@nvidia.com> wrote:
>=20
>=20
> On Sun, 2023-01-22 at 16:58 +0000, Shachar Kagan wrote:
>=20
>> On Sat, 2023-01-21 at 17:04 +0000, Chuck Lever III wrote:
>>>=20
>>>> On Jan 20, 2023, at 3:54 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>=20
>>>> On Fri, 2023-01-20 at 20:21 +0000, Chuck Lever III wrote:
>>>>>=20
>>>>>> On Jan 20, 2023, at 2:52 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>>=20
>>>>>> nfsd_file_cache_purge is called when the server is shutting=20
>>>>>> down, in which case, tearing things down is generally fine, but=20
>>>>>> it also gets called when the exports cache is flushed.
>>>>>=20
>>>>> Yeah... cache flush is probably the case we've been missing.
>>>>>=20
>>>>>=20
>>>>>> Instead of walking the cache and freeing everything=20
>>>>>> unconditionally, handle it the same as when we have a notification o=
f conflicting access.
>>>>>>=20
>>>>>> Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
>>>>>> Reported-by: Ruben Vestergaard <rubenv@drcmr.dk>
>>>>>> Reported-by: Torkil Svensgaard <torkil@drcmr.dk>
>>>>>> Reported-by: Shachar Kagan <skagan@nvidia.com>
>>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> I ran our tests with the commit, the issue didn't occur.
> Thanks for the quick response.

May I add Tested-by: Shachar Kagan <skagan@nvidia.com> ?

--
Chuck Lever




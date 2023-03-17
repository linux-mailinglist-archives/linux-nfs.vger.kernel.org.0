Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874456BEA7F
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 14:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCQNzD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 09:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCQNzC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 09:55:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D314AE1A2
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 06:55:00 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HDFYLo009336;
        Fri, 17 Mar 2023 13:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tRbLTP/IRkBwJUzyhNpJmTFUWIqZ+6R+r4UDzToetxk=;
 b=tMmWbl+lIR4mpAiLU51LUUe32BEHhJH0yyKGTLLoZbzxt7xKMxqBpwMx/jD1YmqNtO9B
 NTJ5W3KOWujIyiKjYMW4wNz+tqt5RKm2m28dUg2WMCNRLNIYWcL4rvhlaDk42X9ReiTR
 QXl6AB/PAeIuNPT8C60es+CK+43M4fsA/CT6wCZA2O0rMmP25ixiERdCbNjlHajw5GLk
 OzUOTM1Nddumqx0HXawjkl8Bnrx2PFdCqZCuFajQUSh137hv9FxLLtnVU6O1F9M9MqD7
 r1uj76fH7xT5UtFu1gHiWE95mra6nLs5JnQPr11bhYBuXvPeRBtAjfhYlSaV66OgPEmH 5A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs263xy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 13:54:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HDgLbp031148;
        Fri, 17 Mar 2023 13:54:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq9k1dxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 13:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hlk2WXtNOqVaXc+u1NjHRwy8oHdyeVWmaNvsY6XM4PjlXXgb5En4i5Bv0pisctmyQtwUlQTLFPwhbw95hge1kl1HVXJq9RYDGa0+y1sIGxX5UQm502WRf9F2qpVte2DNbxpZ9YX6Z6SPx+48DAZE670Ie/nB11X5KdI2eGU1Dp1rKc2KLlDgo51/tjSiwLhN1lKRb8xegSWZwQaKkTSARuAum1K+QIalgDqwC1YijAZHzisKWLUKaWOLEEeNExnzYAW3aRvGLGR5BxtLB350aYdQIHz2OQvpB2uDY0DyFni5owc2rKNm1stsroZXPxXbB0529B1LJ3BqwujPu1nsjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRbLTP/IRkBwJUzyhNpJmTFUWIqZ+6R+r4UDzToetxk=;
 b=Xq8Fvv8xeE5NVjsWB4gwXf3Odfx9AV4pkcCvotiapf+cEriI5OGy1/eMyjSmjYzkG982C6/AsPFqH/w5YnvuzN38E9TsXYuORWYgeapmBmHlmljzyFCf64zsjc7N2GK+1lb/DAci0wxSOHrILKPvwBoIzyVp0copdEC/+zFZk4u9ZVU8VWEZV+3V9WQ1Yd4c4M8JlIIZLbCrCxAoh7ca0nMKCtCvI9t270Y5b2vm1EMvUAbQy2+m6YjzpAYdXFfRohMVlMYGGWNCrD3kfRhXi2K+R4C+7BoMaoK3HLzDK2sjxF/pmdlt3vKQl2eiBED3WiXyLx1I9ZFN+H4c2Klz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRbLTP/IRkBwJUzyhNpJmTFUWIqZ+6R+r4UDzToetxk=;
 b=VoTgDl7OqEjv+reVp3zcrYmhvBOhp4PAdR1GAg4XdZEwMAk7OW1uWTxeAKDD9wJmstbDc+VndC7TwxKBm6XS6M99NoyQIkd/iYE4Nff2kIHKoi1D3GvLrbDLd1g3WfDUC8YbXVwLFAufEgyrTzqO252QKNjG17Zi7+KmpSAoNoo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 13:54:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 13:54:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>
Subject: Re: [PATCH 2/2] sunrpc: add bounds checking to svc_rqst_replace_page
Thread-Topic: [PATCH 2/2] sunrpc: add bounds checking to svc_rqst_replace_page
Thread-Index: AQHZWL8ZX7drP5sCN0GjGgDz8G8l567++6EAgAACY4CAAACSgA==
Date:   Fri, 17 Mar 2023 13:54:49 +0000
Message-ID: <29DB4C06-CB3F-4076-AB90-ABE61A2AEC27@oracle.com>
References: <20230317105608.19393-1-jlayton@kernel.org>
 <20230317105608.19393-2-jlayton@kernel.org>
 <7DAC68F4-8CE7-4578-BBF1-626285B44B6E@oracle.com>
 <ca552165dc70f8268b887bc35d395039ed093861.camel@kernel.org>
In-Reply-To: <ca552165dc70f8268b887bc35d395039ed093861.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4173:EE_
x-ms-office365-filtering-correlation-id: 4601e091-7e8b-4a76-e767-08db26ef2cea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VsVUQc05G/MhhRxo9yB2qqJbVP9DJJJVXQCS9+MlE9sAGdlUnghFHavR0ov/NDWn3ngwK9a5QuzYG8zPG7jH2OhvcDb3JBq4Kv0QTYlei5OwU80a1kIkde/DlLgxQnZPCu5W8Pc0gIGPFijiQX+cxo7N4UlnhXNedwKkNqgL9eZ1jMpZNtbQFLxLRRgm7v2EOkD+b4qK4rJcSiStkf9q/2lfwjxTv3f1V7PzHfm2Bmsx1MEFNvC3Qzya+XXbzJfSGS4D4vlH68J7i8KEOeW1G5bV5yUm0DPGXKMRwWgK1RiKCyihGVWl9lq4Wq388bOlxNXPkl2VcWFLcE9CQgVEUeGd930a/GUb9cbi7tL9CDu1C5K3CXz0vhVIiU1bcs49+XMAElkKPxC2ntiK04417mB2Dl4QSNOvPA4yQPWlZKVH2XitK74qli9WYtdpJclaSJMDOSJw5OQAFQD3eoOj7j4CZR1FycGoTF0BNjajdO4uJNm/kda4fMrGsgUaIf8bq8p5sYzog6HWS6nDrMQG9923biHTQ1UVwf9gOeZRcrP3KRywJJv+u6Jj0ROsksnxZNYB3ETTGzMz5Xo0wdu/ki9jb7gPLKYMzVFCA9WRoydsL2C6WQCkkgdjk88fdK7Q2WUmeL0E46ZHAdtxhxS1lacxBO7QGr3u6AdYLcVTQMKnIqtLJv1+xVXPbVKZSmY3SrBcRZEf5+98Qn+PzC/BRwEoE1WLLVZDwcmfg2m1W8k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199018)(6486002)(36756003)(54906003)(478600001)(4326008)(6916009)(38100700002)(91956017)(2906002)(8676002)(64756008)(66946007)(316002)(66446008)(66556008)(66476007)(38070700005)(76116006)(186003)(2616005)(53546011)(26005)(6506007)(6512007)(71200400001)(41300700001)(33656002)(86362001)(122000001)(8936002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C+K+hdl5r6nk6hnG5QHeSfT1BpKliuf+CpGTDYFE1ZWF8Pq7flT4nLDxrO6L?=
 =?us-ascii?Q?D9pR39jFArX7wvKstL0ZaTdvuk1SjbwyYhZMbwGOeMaL/I3ucEPvfUUOntnp?=
 =?us-ascii?Q?pbrykJsAyiU+emQwbXmgYDSONJICsgOtXeTEh+3tsB/JD9i3X9qUZo+uIb3U?=
 =?us-ascii?Q?wEx2jZCeDHA4x9hTcH16AwwzgPm70TL0gYdq5QdifI1wvwN1D3VAdJD+GITv?=
 =?us-ascii?Q?5r/ExbTR0yf2ypa2fV38rZZ9AZRSqLyb3dUBY/mXh5ov1J5XDt3MIYmaNnlQ?=
 =?us-ascii?Q?drsmzApBNFug/uG3g8YuFFMD2NP0iJXQDuVB+zocjFyMatXYAHkOyZuC7MXm?=
 =?us-ascii?Q?6M5pwGzDRdSPxOvOFsPS5hfBepfafCQ3AMjWSOp2eB+d9dHX++TWz0rEVrqE?=
 =?us-ascii?Q?X3r91MmekLsoVR0bGqZc5gcyjC9fRMr9mbZfs24bMz0uw+vBQdvZhXPkmlYB?=
 =?us-ascii?Q?lzHiWWjMAhi0pro/wyU66ZX0gy5XiZVl2VzAccrQ0y0nwVC5q/oOYoybvJfV?=
 =?us-ascii?Q?159UcXpBPZNOLXMmF9H1wWakLzJAJR1ltDUPIDV8DPV8zJvuTvORDuT85ZRu?=
 =?us-ascii?Q?5HcQpvP8GqPP4k66xPNQ3Mu00IqS4S6vQrdSqK7gHpQeq306oilhb5X9IxJx?=
 =?us-ascii?Q?0It/MhmsEAuReg4kr9TdrN8PctC66NqI+u5/Xx3aSgPSeNJBg7pdHLA0CIxC?=
 =?us-ascii?Q?E4wx3aX+LExcwOj7W5f4gBVfOCAUzjsHk+K1Psf94D/kevhDCTnLIWrWC//f?=
 =?us-ascii?Q?7EZVyvR2sDTG4UyO9jRZBgyE7+PGRupVof0haTNQ5/fIaUNKLRbCK5x/EAp9?=
 =?us-ascii?Q?l8KqhIVYsUHooPy+NvBHOMeX/8yUpaQiREiKG/8vMBhe+/1Sg5ZW69t1odP5?=
 =?us-ascii?Q?Rvk+uu17BQDnGnWseWwzldaJgpK3nwCnqKaED59Bx7OEmBFHm2RVKRQZZxid?=
 =?us-ascii?Q?R5W6bTPGff5V2RzfgQ5IDhAWyyNYeoip/dedozaTiT0cbd91hFp7AHXGQq7T?=
 =?us-ascii?Q?ChutfxKguy5HGrg/WvY8CKclCKp2wsd/+jl+0exkpp+Mvw/+dvypQL22YcY1?=
 =?us-ascii?Q?de5d2gcriAT3zTlcU1JmH14SChhRKrMrAyDJtHRCpXZGjyVAkP63qkVbzPcu?=
 =?us-ascii?Q?V2v6ZgCTlOSEeXIaLVyYqILeJR4PedGraQ2mCPSw9ZFhtCXULgL6Hq2JBtZE?=
 =?us-ascii?Q?1nwnH2J3QGScWvxOisIDle7uKMp6FJvAkLvI/uGKl1MqizKNYyFxo2lXr5To?=
 =?us-ascii?Q?ZrPy+V1qvvy07dwNxLvK/CuKwZmwgcGCu6yDckkdLPOZibrhFeXPSIetSLY1?=
 =?us-ascii?Q?p/tHeOkbC4e81OCbonSQ/pM6rpyypjqGpmaUwQ8fawRP9pVx741p33/6YLqR?=
 =?us-ascii?Q?BYA4NByLhzkPJAlDXIsIrddL2Qtp/vDvt4/TvHySMCoCgl8wrkAWk/UWauy/?=
 =?us-ascii?Q?SVamKwTyEpOyQhnGLhNERQC9sr/oF3CwKrdXsduotpL8bqijt7XQ6hUCsTU9?=
 =?us-ascii?Q?BLGAjOCEkPSEa+PjjI+O+UkBLig0YHSI29uyFxpDRQZiexbbbp4VvTah6Ib+?=
 =?us-ascii?Q?bqWbiShaeGIHWlMZxNnAZSKVlSsdfL/IZQjPNH0XRMLrMQWJe++dky3rdYLF?=
 =?us-ascii?Q?Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2E3D00835722549A67BF59E96A72D98@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q/BKnmwApi8pgb474rLXrnionJ1bUvtVEiNq0rMSXclwe7mQ9hrLktSImD58Hk7sENxp236IdR7Qd38Rv26f5RIJXR56Mtn8hNkLCbuVKfTGAUylhlI57cjJoAbu9se0WigIgGJ6GtoYeLwSiAHCUdNVoSjFFCp1GlzmZ9lXT1IcsUYd+UaOUVJgCui29yrIEZewM49Wbclcc/o5mh43u0LhI6FMPn+CShAOzdyElG7e/YD4ed1zIEs5KGr/+44rwSNXIeMVhiRN7WCjtFuqhqjl8qwBYPEZqJUkFEmhzNIqD7SlRs193DPIkrclDqAtRG5PCtWe1dKxlna/ykxF/LlynK66BdTJORLjqefSFXa7/kkBMLPzkiYnib85N3wU9rNrpkIG+3iRJ/Xh1FWgaMgQbCUqCdbusiFNnq9YAIdjiQIp7CtC0kmh5wSMYZXQQiBaq99MhDi6bZxvYrJntUJYXxxBl1htRPYZ5HtXcLnBgwhg6lBWP94RY0NH2DBTexVxHZ/phwP20erBVvH+B8EKN8AW9lEAzlXyd4+SbwtSzD5597yKLx5awCx0Fa3Eu+XpZ0muM0MqeTYuxHfxjg2avppqxB2VMyA8/MvL2yOz2iVvY3gCP1LZdsXiZByNQwPNlLQUecJ8KBBKhgW4C6/AH58SAIClbMi8lhq8X9JtQz+eDG1OnUPq4/UA/d3LGU2Mw8xk/2yKuJvSJeCGy+TxLuJSUhQVCc0WQ8MVfgQnR0V7DymN832bX6Tmp8zbjS0Y/okYtkFuV0lj4b7cSh5W/BpnG6JvUGw4j49NgdFV2tBcT25/q4yrcOx8BVUTU+bwYTLqkSrzdTu5QmKJ5zvQ1T2bZKdy5IOzcQ7XXQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4601e091-7e8b-4a76-e767-08db26ef2cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 13:54:49.5532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cke2z25+L/z/lhr7755KFAuxVVy/aWJXAJ40MbU0HJ0zyVE9begWup8YJvzDt1O3FpRSQjAhacA8x2kFa84BUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_08,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=920 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170095
X-Proofpoint-ORIG-GUID: KX5aMO0QBRbc9MGkkegNKhBJLr2xlfHo
X-Proofpoint-GUID: KX5aMO0QBRbc9MGkkegNKhBJLr2xlfHo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2023, at 9:52 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-03-17 at 13:44 +0000, Chuck Lever III wrote:
>>=20
>>> On Mar 17, 2023, at 6:56 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> There's no good way to handle this gracefully, but if rq_next_page ends
>>> up pointing outside the array, we can at least crash the box before it
>>> scribbles over too much else.
>>>=20
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> net/sunrpc/svc.c | 10 ++++++++++
>>> 1 file changed, 10 insertions(+)
>>>=20
>>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>>> index fea7ce8fba14..864e62945647 100644
>>> --- a/net/sunrpc/svc.c
>>> +++ b/net/sunrpc/svc.c
>>> @@ -845,6 +845,16 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
>>> */
>>> void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
>>> {
>>> +	struct page **begin, **end;
>>> +
>>> +	/*
>>> +	 * Bounds check: make sure rq_next_page points into the rq_respages
>>> +	 * part of the array.
>>> +	 */
>>> +	begin =3D rqstp->rq_pages;
>>> +	end =3D &rqstp->rq_pages[RPCSVC_MAXPAGES];
>>> +	BUG_ON(rqstp->rq_next_page < begin || rqstp->rq_next_page > end);
>>=20
>> Linus has stated clearly that he does not want BUG_ON assertions
>> if the system is not actually in danger... and this is clearly
>> the result of a software bug, so a crash will occur anyway.
>>=20
>=20
> It'll crash, but only after we scribble over some memory.
>=20
> Actually, it looks like the splice actor can return an error. We could
> return -EIO here or something without doing anything if we hit this case
> and then let that bubble back up to the read?

Yes, if it's possible to fail just the READ operation, that
would be best. Maybe a emitting a trace event would be better
than a pr_warn.


>> Can you make this a pr_warn_once() ?
>>=20
>>=20
>>> +
>>> 	if (*rqstp->rq_next_page) {
>>> 		if (!pagevec_space(&rqstp->rq_pvec))
>>> 			__pagevec_release(&rqstp->rq_pvec);
>>> --=20
>>> 2.39.2
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



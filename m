Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570906BEFBE
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 18:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCQReM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 13:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCQReL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 13:34:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5594551FA6
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 10:34:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HHI3dx021715;
        Fri, 17 Mar 2023 17:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VD6gvAwBmqwQor0uwh2+dk/ME51D/icCAnBRQiGGgtk=;
 b=FhfgH+rIQGQMDjWwGao4WLhQOph802J5vaoDfzVloiWaCj+oOdygvkPo3iABr20QhXct
 d8Y3E7gwv1DT+8vxS2PZBsaeb7/7riKZw2+S96aB5j22X0d/h3ixWghT/fu0XKL9UlTd
 NTwBsb7vtRd97Ju6NStYb/cIkSWystv4tXngktQPat8Oinj5PsNBWh8Vubd+CvQS8PMN
 Hp6kivhRrHvK1xLD8dwFS5F3bGGM0xIT+E7xJXKTjQbcRalB9mQnA5EjrUXh4+u1cr/O
 Qz3Uhz1zXZYtQR3kuHWhoKyEbLkavyshMJkEx6aMlex6p2UlUbVLih2IypRVnv7JWFTs CQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2av9er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 17:33:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HHGwnD001179;
        Fri, 17 Mar 2023 17:33:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbqq7103n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 17:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJMNtFK61woinaXHmEuO7D9B18k/1KOilwl46ZSyYwQOFvcR4M+B0xZInGdP/KGvUL9WBQeFxKkUxLnNcOHmA6zmdwPH+5LmuVJ0nrLe5DJV+ILs3K1w8xcuVMfUpFKfzbMB6CiBR3VzxZ43v9ugzvsLrA2iMrMev+04DStUMoFNMZ7PMg+L5QNkpmfbQaL+9Y7moZRReb5am03MbRPPaLFv3zcOVcJZM33wcEGzl5dImyNu6k5BJZdfcsDvxY1Il15V/MJZoxqudKVnI4vSKeW+C+cgTHC5Ex8mWqV+k2pvDp+MwKMcBGcnWHrRfvasaJhc6X4Ix+sY1zTe29hhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD6gvAwBmqwQor0uwh2+dk/ME51D/icCAnBRQiGGgtk=;
 b=kXJJlBfgpDENzebgkC2VQYtkgpbfFSiIsi8Tdzt31ZGazqA55MbrOAYCCQzB6fmNU+9S+10EH2lVGzk9TDDj2syDL7lt6e54wq77+Huad5z3mpuH2gaSMm2n0TBRxmxdxMGvrbjq5kfbMZ90RdONfDHXNvlf42bqpEvVzR594y8zC6O2nG3DDGsjf7aui8cO2vPvU0fVd9cYa+8W0aPE8YdV/bSo8eHV1KLiiLa30vJHP7VlqfbU0C69TLfyyx2QFer8S/EsHQEiTiNaYdDtDwXtigiBGsc9EEMER7OBzLfhi0uKRabVRwW+kN6Tiq5w4ATLT0FVWM2S3moUkOHiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD6gvAwBmqwQor0uwh2+dk/ME51D/icCAnBRQiGGgtk=;
 b=Kl2BTknuh20ALmX5hPigZnNROzhDFc5XfUNgNyvXIqay+cxogwTW2ODBhSF/Aq3KF3BLN/5ANUVKXOZPabBVnj1lcB4an0rYEPtReRaeVqQvkVL2YsZBo7WECyJV1MHOWaV8N6uFDDOpQchBqooxVZ37nxlrjRsxyLfvBYvdmbU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4305.namprd10.prod.outlook.com (2603:10b6:a03:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 17:33:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 17:33:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/2] nfsd: don't replace page in rq_pages if it's a
 continuation of last page
Thread-Topic: [PATCH v2 1/2] nfsd: don't replace page in rq_pages if it's a
 continuation of last page
Thread-Index: AQHZWPPJ3uW/378GqUmc8Oe+CyIiW67/O2GA
Date:   Fri, 17 Mar 2023 17:33:53 +0000
Message-ID: <28E207C2-B47D-42CF-A531-5EF184D4DED6@oracle.com>
References: <20230317171309.73607-1-jlayton@kernel.org>
In-Reply-To: <20230317171309.73607-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4305:EE_
x-ms-office365-filtering-correlation-id: 438acf94-f391-499d-e9a9-08db270dc786
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfupE7WMkmQv1VtaicSWwUDPON+Sok2aWh1/DfzNyHwHMXIWyGEdK52FWsszsTwZ8oMj3QFmASKJBQz1JWNBsfrYkEgx/J76OOaFSbGPmCeWoaKF57gGyI4BwSCvPpXMMWv2o+L3yZlcMkF/M0Ri8ApShrWxlEkjHJhEqSUTHJlujP1kRhjgO0CzeLXURzUSIS2LwaO84J4bUb0pfsBGqwitNuDCC2tp80PSXb+KPs0bJ4p8gPDKgaLRzpZp7eWaqk0djO4SaAPHSId4N5ie+p45PMPjdDy1tMFuY9ISVWNBj47Q8QHb4uqZn+owqVGCiSfjPepUur1X9HkvaDTzTeTWbKu37orODDH51SFHTNb9wr0gz9oQSM/k+sXlhpf3mhw6/wcU2d6Uj8uisHUljXtQ7snSUPG3La4oJJ1/6iFEjazSdlzXOasb9lVKft7PLvDIXWzWjbuj6t5XD3SYKsCY2ljTYAf2RSuPOsvsdhvJGahSc/Hz+0uy1NxnKsyiDsncegA3uvN8Ajppx2s0Y62ZQ4Npo0wGvEDNBkE+FjeQwB35MNbSJoHbvkrY03mDJcB0lYNnbHqYPnL8VZlEeTggJDXeQc2jFWzvBun/8fqRbxIzF6g8a5qUuikYXF82Xl7p4jbnMIcNd5ylyJOzlK6vCFuYruVLFVQaOufdV5fZa5QrOVGY0rLEFTFHrA3onRgVQqsmyQsgUu2WYH5zZyzRiD3nE4Rz9VmuRnNDk6Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199018)(66899018)(33656002)(36756003)(41300700001)(5660300002)(8936002)(2906002)(38100700002)(86362001)(38070700005)(122000001)(71200400001)(478600001)(64756008)(66446008)(76116006)(66946007)(8676002)(6916009)(966005)(91956017)(6486002)(66476007)(66556008)(4326008)(83380400001)(54906003)(316002)(2616005)(186003)(26005)(6512007)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vlgy0abX6urFzM8a87hPkCjUet3WqHjKM3btj6+fnL9eLKzUSjlpb8Ul8Y6F?=
 =?us-ascii?Q?FPmmntJHK5ikuUYk0+W106s+6i0Mq3dZeRR1ndVzLRaiEc/giryOhVmKqM91?=
 =?us-ascii?Q?28d5cnNT2B0D9UBJa4fXfJegwhvgUN3KJBf5Cuy1eZK9/hugOSD/ibj3Wpdw?=
 =?us-ascii?Q?yT9DIVlcUhCwvzwk/WpV2EeJSiw9jlYyrBCvWO6RvnKAjWUzpdwR+krgD8V5?=
 =?us-ascii?Q?tFsjD+wFqmG7k5tJFiCJG/0phYdFfdY4mi8nECwe0GG5EkA9dEyU9cc/zCSn?=
 =?us-ascii?Q?cVLiiDmihV1Lperxjpn++yRZhKAY2wVTkBknDotmM3CDj4y++1Zgv4IBaJyg?=
 =?us-ascii?Q?5PQl+HOMSfQlp+w5kUfl1/eCY9aeaNGyMzUHBIvO5tfs6l6XOcgeqW9K24P1?=
 =?us-ascii?Q?VLBToSOeLLg8d+C//vd5EQdXugIMR0DQHlcjHZIFOOQcTh09K81nO+TI8Ff8?=
 =?us-ascii?Q?LBM+sCj/lT4en0TfIqncjo1yURVKz6OAhxe5MAWDHuSjLeW45tvfJcUeE3B3?=
 =?us-ascii?Q?JUcXrznqi5n0PEzI5meoGpndWoA19wESb2oI67uGr6FkgjJzbjl2uujOxFdX?=
 =?us-ascii?Q?tzIE9DwZJisfyVa2rzY0mKhCsKI7xVtIrbxbr+b1km8KSxOskrFcQO8u6UdY?=
 =?us-ascii?Q?PlEVp5S4LDYCY5Oo37LG2fIjvpLlZSNFkA3FrOJV9xRCYu5uQvBsr1BWnQ1w?=
 =?us-ascii?Q?ZAMRFkqMTP0p6UsZ6fEtYcA/YZA81/Y2O0nKBFBr4r2/A3OA+5nl2jINhg05?=
 =?us-ascii?Q?udlUO4yYlHO9D1vvPRcURgHEgixLJhKl0pJxkckgTvJWVlnuhlmIlJR32cwM?=
 =?us-ascii?Q?1+/Ww2XzqnZ6oE2hQytG8fRA6FUJZ06j3kNpCkCR8c0wm3NOneXWUybUz3W4?=
 =?us-ascii?Q?w4g8WWFYt2ATnOZvdZelThMGM6zPSvxIag2AWu2IkBQZVEA8zHH78vJ2ZTTe?=
 =?us-ascii?Q?5kwlAUe8TGv64f6ZRqyk5Ti399XKbMpmmEF+CoP420wDvEDfE6L8T/2QvzjW?=
 =?us-ascii?Q?K5KmLVf1OfiKaQv9Yxpo0svGOYuV2Mpvu8oAdx4jcgZxmDeaygi8xYsk7Wd/?=
 =?us-ascii?Q?CyR0+3fmSNoagYotff0pcaHW/IY/FjxO8gr5HmVgiR7Cyxpa7yLtRw8LHrKD?=
 =?us-ascii?Q?qWDdcuka/b5/13wTSzXLRl6ZU7X+Xj7ZuSY+6/9y/kJs4zpxwYuGV859U1kK?=
 =?us-ascii?Q?2RLQT9chu4oO0vMrBXWOnSGMYImwcMOz1DmZGspHcj6+DpjB9O2bPU132iPr?=
 =?us-ascii?Q?8SAMV+sLDe8cYKiqPNjiV2iAE6qd9he5CwRd4++IOyoWrp8HbaU6U3sXxrnP?=
 =?us-ascii?Q?Mavqsq8Z1/GFYRbj7BJlY7/MRNC2aVioyzU4utfa8gnDezVbR7TSOgay6XWm?=
 =?us-ascii?Q?zCCJqaLu8s1y3cOkjwG4RZnxEaLK1slfhBmQXBl6C5HadISSrcfnt9g1mWrq?=
 =?us-ascii?Q?x2oW1DYwHLeBWzzXLU3JwYFZNiNZ/EFZegiTkCtfc8Oa0wgDcTRJJkmazmVJ?=
 =?us-ascii?Q?pAdE7yrb0afxYzboLGdW4RZlNp554zp9uuwZENirt4Oet8LGTVqN9kK5SJxg?=
 =?us-ascii?Q?nPBBlZyMWprZAv5v9PbaYZxPPECwWNhxvlVnOLmr5NeGXq2ECQ91q+jfUXsd?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F778AFA52F0864E8DF1FD956E8F01F0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f7XRo0AFDU+2u8TLzMGTQRWhKH6F9iujbuNa0DEKkOgFM5b8JSXPu6dg+HoUXqIbRXkIIPXMUlFIllQP1vR4ohhHQf/AvheYcqSv7DIxDmY7UqQu5ets4kzzztq66POZuMih+fgRqrYWR8DPgWZrbkuuColwwkfeZygnGTD2LOHbaYhd8ECkWCiZ12MY3Z3iVraZKDuNbRKjI00rNB8G4evokiTotDPdJUDbKqBiyW1GVmz8V8gkly8Tsc0Tg1nIOHwbY/WaSbJQFU186q+KL6Zejgr2P86FxxDRlgMjm8eaujpS/pk534oAV/5spBS/T7Ni9I+VSFp52ozEt9GXC05SpAQixbZPyocv37qUYKLfPtr7GbHxUInS9H/2vaIC/QlihJ3ya5RVGAOVB2Dbn3tWznIia6VlrVYxYu23xE8ICMnHaHetReHSk4EghbKOtT0Ll306yMkFglmQmFp9chEfVsQ6EeIMZ9pfs2I5UlB663Ss56meaXqndSHuquGXlwZKWHe+pD4QYPgmXBF/ygsifuD1Hu5ripSxsIk8KEoNk6IQ9dPTs4lgHqOqdMpHLk317be73XAvgNngFcARexfIewNlAZIFGQM9cF8g2CWjPErs33F0t3UyOgVAKNPhjUEf7rP2MuITW/8HNMbhiICNZZ6yFTuce22T41S/fq9KwYJFRUY8CJtY2VlSNg9t4V8gTHW9KIWHNB99kpY9tta0JUQg+gCSMWVCMZc9o6Q6ZpYqToLA47yM1/uWUdQ6YODrdjbzT0ckWXSzjztcQtLQMwpiTjvhmisdvvvSJ+DgBdiVtBBiSx29Fv+I2hxEBbBhOxgGCw8fkZn0EKo1JWJlEu/6K+OzrrBZsjCS3V97TaP3+02D+5BzrGLbSCc+/MzYK9n2LhX8S5Y04JNOXg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438acf94-f391-499d-e9a9-08db270dc786
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 17:33:53.8154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fh1vaUBLcMLHPmczvpn0YSEE6T8a1OLNZ60816/avi1mqvusXf1k/7XJzNRL4YZb6UclitQ2qNDPyWrY/mz3FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170117
X-Proofpoint-ORIG-GUID: ZEXKSwAXwRJZ2mUtYV9q7aPR6Jp-KpyX
X-Proofpoint-GUID: ZEXKSwAXwRJZ2mUtYV9q7aPR6Jp-KpyX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2023, at 1:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> The splice read calls nfsd_splice_actor to put the pages containing file
> data into the svc_rqst->rq_pages array. It's possible however to get a
> splice result that only has a partial page at the end, if (e.g.) the
> filesystem hands back a short read that doesn't cover the whole page.
>=20
> nfsd_splice_actor will plop the partial page into its rq_pages array and
> return. Then later, when nfsd_splice_actor is called again, the
> remainder of the page may end up being filled out. At this point,
> nfsd_splice_actor will put the page into the array _again_ corrupting
> the reply. If this is done enough times, rq_next_page will overrun the
> array and corrupt the trailing fields -- the rq_respages and
> rq_next_page pointers themselves.
>=20
> If we've already added the page to the array in the last pass, don't add
> it to the array a second time when dealing with a splice continuation.
> This was originally handled properly in nfsd_splice_actor, but commit
> 91e23b1c3982 removed the check for it.
>=20
> Fixes: 91e23b1c3982 ("NFSD: Clean up nfsd_splice_actor()")
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Reported-by: Dario Lesca <d.lesca@solinos.it>
> Tested-by: David Critch <dcritch@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2150630
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I've applied this one internally for due-diligence testing.
I'll wait a couple of days for review comments, so it's
not likely to make v6.3-rc3 on Sunday.


> ---
> fs/nfsd/vfs.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 502e1b7742db..97b38b47c563 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -941,8 +941,14 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, stru=
ct pipe_buffer *buf,
> 	struct page *last_page;
>=20
> 	last_page =3D page + (offset + sd->len - 1) / PAGE_SIZE;
> -	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++)
> -		svc_rqst_replace_page(rqstp, page);
> +	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++) {
> +		/*
> +		 * Skip page replacement when extending the contents
> +		 * of the current page.
> +		 */
> +		if (page !=3D *(rqstp->rq_next_page - 1))
> +			svc_rqst_replace_page(rqstp, page);
> +	}
> 	if (rqstp->rq_res.page_len =3D=3D 0)	// first call
> 		rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
> 	rqstp->rq_res.page_len +=3D sd->len;
> --=20
> 2.39.2
>=20

--
Chuck Lever



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB6743F12
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjF3Pkl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jun 2023 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjF3Pkk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jun 2023 11:40:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6AEB4
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 08:40:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UEmo87011013;
        Fri, 30 Jun 2023 15:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SqVeX712zGATIHhuFkr1r98n87FoxwYYm7NrRL+kJDE=;
 b=JvEKeLa79yJmMnZ8RtPSh4oEut9xoX3HXaHDdg+bedYu9UZx8I3Ggqn81+8Vn9XctDjh
 0r7HdBI1TOoJt9nBy95f9EBMS+MzBQb9RaPK7T01H+8ZdZ1h6b6CbQwRMTmtvwfllqug
 p55QCQf2vEGWAAMt+9tLD1IhmVOJFo0YGm7OlpbkUwX+huZRh8LxeD2kyoHRpk++A5Ch
 PFtzUxOLzIvzttXzwFptXdjEfTL2cYSZJw/LP5pgxaCF2ijfQTqMolfTGKPNEp9/zh4H
 XKDnBhrPU6BEmFt6wN8SDG+R+PbCKSAlGrNi4mjlSjk9u4+L56sDiB+pD8HkdTswzdVn nA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq93h5f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 15:40:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UFWY3b013125;
        Fri, 30 Jun 2023 15:40:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx98630-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 15:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUiS02G51tRnFPvVFdtjiBAyptUO6wvdw5de4+SUAnXw8/ijTq6NXnoFGlTH9ThM7MGMSAdzmF3bNEOZ4rshjEp/jpzIJWH4O7jVoZG/3mvIzO+rdcj4XUUI70fDC8w0tKNqfYbCyY2VrXwP7nD2TiYzN01IM2442KQ3T018i5PNVL1Zzf278EF4sMeGEd6XLuT/AvmV9AzlgipKDVUr2pLVxQb02ZTz+dbfADWqSoCLTXWcslKigvx1twCk+nKnt3kggXowsdPnmDO4Rn3BLrrilsuEcyv4mGWBDa3nu9RiIVCaR1rHdQi6cV5CM+fHLd22o9I4NMKW3CP9DidotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqVeX712zGATIHhuFkr1r98n87FoxwYYm7NrRL+kJDE=;
 b=CHynzqaWRpidV9jZgADAaa2LZUmg9e3tvo5n0CAv50ET3dVoormeMI6Dp2kMNsOljwXW+3Krj/bQ6+RFb7JhV4LfVeOnP4yITEuwlE+SFvz02fYKNNRjzE+Bjo5nu4o5lXegITc3/Ks4/KNuui5hEQENO5JtGjvEjm6WEQlY+vwBfkOUwaXqBuWLsQC15+OirNLaDGiQsX/GeAOoFwVPf8aoxycPWr+cFWaQ8YbGfTyRCanhUigu94EU1oCFz6AsotzGSPQHCZtGBdDJ6CgcDfQv8PqSzLM/LU+VSOnvoYRtRUENcIMyJzhIjxJO9EBAGiS0ePXgO9RgDe1TBuTLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqVeX712zGATIHhuFkr1r98n87FoxwYYm7NrRL+kJDE=;
 b=mw9upA3ZwskbuGis+ovtHmISAnMAEzyWx7DF3aNt5GNJ9UHJMV4sJUnP+k/aUbyqV4xV6YGp0IBfivOdo8lFmE2ZKWu23eAYp5z79AHPCwcQqfCv68rEnUBhMLbocKGH+MKiYG1mItBgLUu9JzcW/CssO40RIT4Om7lYSc6C4D4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6693.namprd10.prod.outlook.com (2603:10b6:8:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:40:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6544.012; Fri, 30 Jun 2023
 15:40:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] NFSD: Enable write delegation support for NFSv4.1+
 client
Thread-Topic: [PATCH v7 4/4] NFSD: Enable write delegation support for
 NFSv4.1+ client
Thread-Index: AQHZqvWX2/XR2HMAyEi1yPanmngxjq+jfG4A
Date:   Fri, 30 Jun 2023 15:40:31 +0000
Message-ID: <153C6CF8-699C-4457-9116-0E22498136C7@oracle.com>
References: <1688089960-24568-1-git-send-email-dai.ngo@oracle.com>
 <1688089960-24568-5-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1688089960-24568-5-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6693:EE_
x-ms-office365-filtering-correlation-id: 402bac6b-3b8f-4c05-a7ea-08db7980563e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XWP+RvLN0F6XGtNogEbQueuRRjfG6KymVEVcDWVaocJxYmQwZw5NrYoiJw5gWPt6fB2fOItS60Hfc+wnMA+W0un0egLYkZdp2MlIraq7MSY4iBtWbrodLlpo9FN6Drk44kKOYhxt3PkBtYWTixnZXx0Bzu+PHPbSMCJMt9ZwcRLiDJCI3sLNlYSwDXCRCq8a/vO1GTgLTmG/S1q3KJYvO2IZj9Xkoharf1Q/6MhYp9fx0nzkCAbAcHi0Wjckf+ZQR5CTBuNF2ypzejjtrLgkKp59EqmP9iC47Pld5PHi4NzYnHe3iaK4blfGIc2Kxn81Ly+V4UE+w1tpNZ6pw0aGIcl7f9jgEsCHKBjgV9gDXFt+eqiKmMy6Ezq8o6CXC1Mt7A7bdAsYRSNghqTnTRbgoaTZKlbvwqC6Tfz7vWGjFkVM0KyGVNafLk6cGuFAOybynbkZjr/zLZ83ZqwlhaRFiOdGkZQok63LMVS4j4jpHGlFnsBHa5EBnYAAD9IhkZUZX28MKd+/1ygN2yvFhxHt5P7BD8cGfXJPtv7yk3lkXq/cN7gpYIJxJqTN9q7xomhxYopDEZeOaJr9dvJ2aP/ik7DAj9NN9OZ3NcZ6SuA5g9NLW7CTPm92wsIUCOmUSynnXynWFIbSxIFsYT6QeeNMQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(86362001)(54906003)(37006003)(71200400001)(8936002)(8676002)(6862004)(5660300002)(26005)(6506007)(53546011)(33656002)(6486002)(478600001)(66946007)(66556008)(66476007)(66446008)(64756008)(6636002)(4326008)(6512007)(41300700001)(76116006)(316002)(91956017)(186003)(38070700005)(2616005)(2906002)(83380400001)(36756003)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O1DKM9We5HeQQSL07wKiS3JtXXCSDo+cKuEylRz7qC9BqVfHwZNGCnmcfBlY?=
 =?us-ascii?Q?4tJWqP7O+8EUk9vLI7p/QAOcu7qAS0b/htWtDCZY92h8dWqaVgsEP64IZW1u?=
 =?us-ascii?Q?wvJmmpf+ox6vLOuUPAxtLpogIwmMoYtHP4O6c1A2C7rZVlnhTFxYbJL4wdS4?=
 =?us-ascii?Q?TxherEqlR6U05BngplNev4qlBzGGca+udo1I3pkIcAoWq8DO83eC8spuqtGv?=
 =?us-ascii?Q?GztWrax4iPKVUhdc7Ld8OVPumkVDP8iznFiNDewnzBgzwHSuxdy9iyrgbeuK?=
 =?us-ascii?Q?yPvvOAf4rPSBwOIGP6WVnzTZfd1P0WrrjZiH/xvjgLnxU0MIc5mWf1AAF5zR?=
 =?us-ascii?Q?6yF9Y1WBNx57xRrqig9Y/fXhVGC2f/VFM+leM0YWED9Qs9JhWnatWNt5YCkd?=
 =?us-ascii?Q?svnJOoyZNotQPrCDBFm+OUxQG+fvsmI9aw077ZKaYy10cdfFDBoaknoVQE+O?=
 =?us-ascii?Q?IwIi+RXXHWOKHNbok8CePS4VA0CoiRlDcO2BvNIMclMxxvzPIbKTmSoruvtX?=
 =?us-ascii?Q?vBC1COHoYqiXb53lNstaRroP+DQYHcdMLUWG8oe1yDpn99uwOPajGYjnpSml?=
 =?us-ascii?Q?OerGeMRI/0A706pg5csz7IsYnokB8FcTcahJ6YL78evW6OLsXFILVe0P2UYi?=
 =?us-ascii?Q?YhYTZ37rubMfJduF6B5pnjnvrcRxe7UazZKXIZJ8/YDdRIjsvi2Sv2znSGel?=
 =?us-ascii?Q?2lFOZn7RCtKpSM5jOwlQs0U0JIXZCQArPWM9gRB4E5wrKDldcod+GY8Rmir9?=
 =?us-ascii?Q?VdGIs5jjgukPMV/VUw+/muIqjUrIYtUlAsFBlWeUaIF2oF3gz0CLbdwTUeX4?=
 =?us-ascii?Q?kiQNEuuLBVzUrXRNpvr6qXBFHteTICmzEsKZmzrNoZwLqttOaaY3kZu/vJba?=
 =?us-ascii?Q?HDbW+r+eHucnbECvE2kgs+aSHOSruAxLeqQW0bWVsLk5WtBaLmCoMihjbJjp?=
 =?us-ascii?Q?s1Ukj9wzaexQ5AVoIQYlgxOdOzSDqhesJrLpPOpce9aeW2hAvxBKOmUvYhL6?=
 =?us-ascii?Q?/EOW/8ALsYRUlsPFlpNgmSJQOXzYyB9b+UdUzHI+43WpSmMWESUSBDa/nqAN?=
 =?us-ascii?Q?rn4izVQTYWru3sJF/jIJmg3S0iot9RVAD1c11KNm0uS55Ek+BbZ0e1Af5bZ4?=
 =?us-ascii?Q?DxJ4vhfVGE5rBiUIjIINWNSkVLDd5STXVapv8T/b8feoshwAycimw8qtaMCJ?=
 =?us-ascii?Q?BWE0dA3kaFE9pUbGkZUhZGmRzrPeG85b4iuaWzuYGjudmZ1sQ/B+BtroQLOt?=
 =?us-ascii?Q?8+mDdox4SUX4gN33akKCy6NDZXKRu0s9IUctWHSTZyvDsywIM4ygu8KftEfO?=
 =?us-ascii?Q?lnRkDbjNrHzgROknlTkndWKN+ZdYbRosJ75GWMUPKu9JJbSZQhTmMBOk0ps6?=
 =?us-ascii?Q?YL0N5fCCX5QKoN24noyEvVsJJw2dkGl/oHyEJp/rkP6v80wQ3FD0sUFoM9NX?=
 =?us-ascii?Q?/8qfEcD9sU0D42pniVl1rDngCxPWbkcn1lH0HmkWGbX4tpUzMoaLU6w/q9Xs?=
 =?us-ascii?Q?DzH2JqrWDuoODsgcrl+H6N5d2N9aPKT6zx4vusyHKHcoZljA0/jGm01IT7Ek?=
 =?us-ascii?Q?F/OQT4aZB3ah714tyS1qJ7Cj21HLeQ/tBSbVBRSqmiSQvhN4colNEPJCC+IO?=
 =?us-ascii?Q?Jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1575431E032B84408957A804C6A26094@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Bn9hdsu3XH4fmwvUobtt/yKyZVvjOwCV7Zdb8vx/hDoKRW1hJtWXecYqgRqC+cRjK7/KI/2zUz/pewV+2VQd75pizhkvKF+gXq0Fda+/B+t2iE13TloHVCW5ikC+vu79GkCL3fKgvspvWbxcU6OqCsebOJ0EYXFD6BS8y8t98eQcxFybttB7dv7YYvmp9mc6dPwDsnR7ZTvFm7lcJyf3Gd7O4uKooXfgMb+smYA/R9aEaUixFKWmp6kYIsu/E8rmBWTfutiHlRX05VWBBm5fVWDyyYJeTWmrZBlvfOB8JRllZSIIkuIdFG2nwXe0ULJJBKR8Z2RF34CGq6x668NwtnGap19PVuwbscGwNYq2ERhJ6k1fh7+ZPsjsjbg5XZT5JeyfndkeevIjBqy67Gu39mWbLWXXbwc5fi5VdyF/osM6XWm2itAnxCH9elIbkjNwTGl9d6bQZmhP+jaayzAr9aWGRjkP9jB8vSfrCrbHXge6MYVBGymY1Cd3IQxkti9961WepNyxBokBkDlFxUC5Ir6htULXF9iEr6XzfZWZb0mJe6Iy4tw7WA43vax4/CcT0B4UTZg14Gwu+ygCp86rk2ew9DbuspoaATtlYp6VgnkswxGquFneQGWO0JBoCazmUSNS9fW0BR/J4tWld6xqe6rsG+QhbKC7H7ZiWs0MsJRYL7GqDL1f2yhpJhzP+xguHtjSoUYZk36UOa+NxqRnCev5QXv4Bm/zZXGPy5tLVPVlilrre6obkogWCCg04v/CuSyGP3MFbcTTsMV0FsZvWtcXquw0MLlCcewCzfRqbx8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402bac6b-3b8f-4c05-a7ea-08db7980563e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 15:40:31.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qo+JbaEaa+NEAStVNbQFj8sCD4E7SFvJEtKDtjmTL0hDCDnnNlBxFKTvUOOav2ZhRnDk++14WTApV0aY4ALU2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_08,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300133
X-Proofpoint-ORIG-GUID: VawYE2IQflKieo5UsYrFsNI8qSLOtPuh
X-Proofpoint-GUID: VawYE2IQflKieo5UsYrFsNI8qSLOtPuh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 29, 2023, at 9:52 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> This patch grants write delegations for OPEN with NFS4_SHARE_ACCESS_WRITE
> if there is no conflict with other OPENs.
>=20
> Write delegation conflicts with another OPEN, REMOVE, RENAME and SETATTR
> are handled the same as read delegation using notify_change,
> try_break_deleg.
>=20
> The NFSv4.0 protocol does not enable a server to determine that a
> conflicting GETATTR originated from the client holding the
> delegation versus coming from some other client. With NFSv4.1 and
> later, the SEQUENCE operation that begins each COMPOUND contains a
> client ID, so delegation recall can be safely squelched in this case.
>=20
> With NFSv4.0, therefore, the server must recall or send a CB_GETATTR
> (per RFC 7530 Section 16.7.5) even when the GETATTR originates from
> the client holding that delegation.
>=20
> An NFSv4.0 client can trigger a pathological situation if it always
> sends a DELEGRETURN preceded by a conflicting GETATTR in the same
> COMPOUND. COMPOUND execution will always stop at the GETATTR and the
> DELEGRETURN will never get executed. The server eventually revokes
> the delegation, which can result in loss of open or lock state.
>=20
> Tracepoint added to track whether read or write delegation is granted.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++-----------
> fs/nfsd/trace.h     |  1 +
> 2 files changed, 30 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4c96cfe19531..15b5043eeca5 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1144,7 +1144,7 @@ static void block_delegations(struct knfsd_fh *fh)
>=20
> static struct nfs4_delegation *
> alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
> - struct nfs4_clnt_odstate *odstate)
> + struct nfs4_clnt_odstate *odstate, u32 dl_type)
> {
> struct nfs4_delegation *dp;
> long n;
> @@ -1170,7 +1170,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nf=
s4_file *fp,
> INIT_LIST_HEAD(&dp->dl_recall_lru);
> dp->dl_clnt_odstate =3D odstate;
> get_clnt_odstate(odstate);
> - dp->dl_type =3D NFS4_OPEN_DELEGATE_READ;
> + dp->dl_type =3D dl_type;
> dp->dl_retries =3D 1;
> dp->dl_recalled =3D false;
> nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
> @@ -5451,6 +5451,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct=
 nfs4_ol_stateid *stp,
> struct nfs4_delegation *dp;
> struct nfsd_file *nf;
> struct file_lock *fl;
> + u32 dl_type;
>=20
> /*
> * The fi_had_conflict and nfs_get_existing_delegation checks
> @@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
> if (fp->fi_had_conflict)
> return ERR_PTR(-EAGAIN);
>=20
> - nf =3D find_readable_file(fp);
> + if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> + nf =3D find_writeable_file(fp);
> + dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> + } else {
> + nf =3D find_readable_file(fp);
> + dl_type =3D NFS4_OPEN_DELEGATE_READ;
> + }
> if (!nf) {
> /*
> * We probably could attempt another open and get a read
> @@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
> return ERR_PTR(status);
>=20
> status =3D -ENOMEM;
> - dp =3D alloc_init_deleg(clp, fp, odstate);
> + dp =3D alloc_init_deleg(clp, fp, odstate, dl_type);
> if (!dp)
> goto out_delegees;
>=20
> - fl =3D nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
> + fl =3D nfs4_alloc_init_lease(dp, dl_type);
> if (!fl)
> goto out_clnt_odstate;
>=20
> @@ -5570,8 +5577,13 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4=
_open *open, int status)
> /*
>  * Attempt to hand out a delegation.
>  *
> - * Note we don't support write delegations, and won't until the vfs has
> - * proper support for them.
> + * Note we don't support write delegations for NFSv4.0 client since the =
Linux
> + * client behavior is not compliant with RFC 7530 Section 16.7.5 with re=
gard
> + * to handle the conflict GETATTR. It expects the server to look ahead i=
n the
> + * compound (PUTFH, GETATTR, DELEGRETURN) to find a stateid in order to
> + * determine whether the client that sends the GETATTR is the same with =
the
> + * client that holds the write delegation. RFC 7530 spec does not call f=
or
> + * the server to look ahead in order to service the conflict GETATTR op.

I'll take these 4 for v6.6, and update this comment to match the patch
description as I apply the patches.


>  */
> static void
> nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp=
,
> @@ -5590,8 +5602,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
> case NFS4_OPEN_CLAIM_PREVIOUS:
> if (!cb_up)
> open->op_recall =3D 1;
> - if (open->op_delegate_type !=3D NFS4_OPEN_DELEGATE_READ)
> - goto out_no_deleg;
> break;
> case NFS4_OPEN_CLAIM_NULL:
> parent =3D currentfh;
> @@ -5606,6 +5616,9 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
> goto out_no_deleg;
> if (!cb_up || !(oo->oo_flags & NFS4_OO_CONFIRMED))
> goto out_no_deleg;
> + if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE &&
> + !clp->cl_minorversion)
> + goto out_no_deleg;
> break;
> default:
> goto out_no_deleg;
> @@ -5616,8 +5629,13 @@ nfs4_open_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
>=20
> memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl=
_stid.sc_stateid));
>=20
> - trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> - open->op_delegate_type =3D NFS4_OPEN_DELEGATE_READ;
> + if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> + open->op_delegate_type =3D NFS4_OPEN_DELEGATE_WRITE;
> + trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> + } else {
> + open->op_delegate_type =3D NFS4_OPEN_DELEGATE_READ;
> + trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> + }
> nfs4_put_stid(&dp->dl_stid);
> return;
> out_no_deleg:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 72a906a053dc..56f28364cc6b 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -607,6 +607,7 @@ DEFINE_STATEID_EVENT(layout_recall_release);
>=20
> DEFINE_STATEID_EVENT(open);
> DEFINE_STATEID_EVENT(deleg_read);
> +DEFINE_STATEID_EVENT(deleg_write);
> DEFINE_STATEID_EVENT(deleg_return);
> DEFINE_STATEID_EVENT(deleg_recall);
>=20
> --=20
> 2.39.3
>=20

--
Chuck Lever



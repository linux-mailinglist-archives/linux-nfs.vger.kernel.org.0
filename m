Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC8C7A6764
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Sep 2023 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjISO4s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Sep 2023 10:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjISO4m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Sep 2023 10:56:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE50BC
        for <linux-nfs@vger.kernel.org>; Tue, 19 Sep 2023 07:56:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JE72Gb000359;
        Tue, 19 Sep 2023 14:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YhshRMXLryPAPJBEOTcWMF1YhIzxue0M3j43VUkefYk=;
 b=xXCHkhYY1E7cXuz1Xoxmwkl2qSmTcwJY5Ul+MWglnBbLYg51PnJx0f9A7qPecmIIga3m
 NVWLfxwdQvspt9AqucoAYralh0CfmypIInwxP6sN4w8pX+jwrfTk5SLsHmkqb9W/pwhV
 rIo8wKEFnLgnqW93z/N53YZZvp35k/xoTr7eaYjsn+ximOhi115SnJdugILMOivNydHZ
 XddcH+q1qpnPssV6IRUr0dEIJ2Xz0N8Wf4wfCpaerlTZF+euNeD5uQIe6lBMo27/N05h
 H55q5ba+WIUzTatSIvFvtl8oH1alLJ/jHdFjqOGM/juN/e6kXFtbTx98u8uVb2sxpeiZ Cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53yu52qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 14:56:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JEmko0016081;
        Tue, 19 Sep 2023 14:56:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t5gskk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 14:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh1p6CCDFlvNftCOL3IWVt3GHp7Uln4izTzq51NTQBP3Ng0PJizJyaaH/l0bMqO14XnvREKCQ3aGe9rpR5+Pu0atjU3jYZCHlRorbwCdXpqUYuWwc8gSDX6gquHfLskjzdQatAxJ+Lyh+oyelEs5Qia1zZ97dtBChYTjvDO9Tlnfsl8SeWZ9v7a0aKC/MLNpUz6f7PhtJ7E3OO2xVSVlO4hXAs9msEz2Z/bZnXVgUZez3l83qyJVH9L7/DTZEn9kHoYfQc3zhVz4s2+1mr5+gZINHtgS+NZmZYmGNf1OZIO5v6ADgTf5lyjnYLSlSUmVo4Y6/3/Sm5LMzAjZX1KtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhshRMXLryPAPJBEOTcWMF1YhIzxue0M3j43VUkefYk=;
 b=g6erj7bbqFMzEUCayhlNJG6x++5virnfS/BNQXjDo1jRctySbw0usUYQMRjGB52D8g74cJJoXCs5rBrrXyWdwXv3WRf4K67N0JTjD25UU6tPA2fDUv64yD3b4TcPvtzZ+lYy1wpfoLGvxnJUnwW37jgdlh43CXIs5GkF/jB+hilWEZ/INyniEpdE9IvoELJuCAcJNxBWFSqUtGl7WBZXBTKiauwcsnFlbD0HCys+GF+fMHfByEBW3ML7udtHQxdA2XH9sdZxmSmW728Xds2PQZ3ixXncKxiEhvzGAc/KkBHbzixOFQ9kCF0jALs9cdOp3DEt/Skuhurkte5POlGPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhshRMXLryPAPJBEOTcWMF1YhIzxue0M3j43VUkefYk=;
 b=jxycK0B//gFaUxfbQ1A8q1nj+UVGY4bewBb4MIjY7/6zlNBDiSVyzzFI/tigGQQd3LtcL/4mzM9anQJzk1QTK4MU/zKLaXHy3Fre3eF25agTDY3WxSHhBvFk4IeCkx2ph7BE2T2Im5NNdFH1aXVNXOFn7yO/StdeYcFYfac98NQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6784.namprd10.prod.outlook.com (2603:10b6:208:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 14:56:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 14:56:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] SUNRPC: Remove BUG_ON call sites
Thread-Topic: [PATCH v1] SUNRPC: Remove BUG_ON call sites
Thread-Index: AQHZ6jsnlplyHr80ZkCQVEI22FKIdbAhRJiAgAD5z4A=
Date:   Tue, 19 Sep 2023 14:56:24 +0000
Message-ID: <4B0E5D89-B784-4864-9BA8-F7F6C0F02912@oracle.com>
References: <169504668787.134583.4338728458451666583.stgit@manet.1015granger.net>
 <169508172758.19404.11033097632795181738@noble.neil.brown.name>
In-Reply-To: <169508172758.19404.11033097632795181738@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6784:EE_
x-ms-office365-filtering-correlation-id: c1a6725e-eb95-4b27-3d44-08dbb9209860
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cx2E7bkHYuePEC72YUYvd/Vs8/mxVp0NUsK0OywXj+qVmEEd6o7jknAg19VvDVSBHwaptcRbgpH126J9joRpowaMxyflBb4iV/bL3Cfr5OaX/vNKDlnblX8a1QfggGioj8tI2h7kYKJ2j04oFiGfZ5K8cBn47O9JUBzzVzVplVLJhOThZdgQTXF3g7QY4eL8t7wDSn5Yba9KBJX4264D9Fu/e+Az7ywJ/vonigHMUOGzB5sTOJLG6UOoLiL9l9kUECKfDH1ZwBlMpebwOONICZRCGdeawmp9kUQcB77mDAMy+5qarmo7amBVbxpTwRRHSMM8dZ0qwVPoPYvhygpfWwVWLsM56kUAQVC2yEpLNXLe8FyzNRmzY6nX4Vz+HzwBtSDJA9MPMR3DfjUR+3B7/4RgGXSM4GPxdAJN5drtgj4dv6k+hL7efhUlwQXlvX2lFoYcdUZI/d1XLo/qrpd3KdzAJwPMnKWZMoFkYkW9SS7T8tgOEiIsJXdOOz2EtXBmgfxbiCaKZ9dpq6RjJd56qsi4qVCssV80p03MbVkjCuy01Zp8EOTimoUO6VShJGovGdiw2yc7euTEWHARA+sMyNXjEkjHiYKTcA4lOOVKFb/cdlM8OXvE3J6dcISaSL6i2Z07cTXpatZDqR1pB6VJ5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199024)(186009)(1800799009)(6486002)(5660300002)(6506007)(53546011)(86362001)(6512007)(54906003)(316002)(64756008)(66446008)(38070700005)(66946007)(66476007)(38100700002)(66556008)(41300700001)(76116006)(91956017)(71200400001)(478600001)(6916009)(2616005)(8936002)(26005)(2906002)(33656002)(36756003)(83380400001)(4326008)(8676002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/wgL7JMSzDb9F/PyqOPgnWFS+y2exf1aanVoIEyHTww46IS3gKRNvFzqQmc+?=
 =?us-ascii?Q?XhrhRq1scHi0bMpj0ZlUWRSeRcWW5ejUyw8Kc5UG5D0qmzILSYpfr6A+Tcwy?=
 =?us-ascii?Q?8pwk+ojQMXLi4naRwxrUwaXJnEW7xrtpFvGce5m3n+2DhwTRPiS6tv2WEhjw?=
 =?us-ascii?Q?Qr9lU9mJXGCd+rsG2H8qOd8ZGnifwGfSkvhJERlHMEdiGXhfaqYwJDI4RHeE?=
 =?us-ascii?Q?KwYDzfR7DtrW8gXJ1NHZZ3soqkO3H9Ey2RO2HjjH2YkmtaYMbR8cAOeNOZO4?=
 =?us-ascii?Q?x4kyujWVd7sO5bkXjCqX8qvMsxg552Yl/q62k6pr3jpTKg2WKJXWyrNVCBkG?=
 =?us-ascii?Q?aXiKBkQEMictcguoaexaobvWLfrIuYkSWFqxRzZfid1Hd8luweamNa7nIgh/?=
 =?us-ascii?Q?VNJtyoBt5fk32npbctiHBGfvAaPQbNEHYH0WjNJWJbsmSfeG7fPM+CSXQa+w?=
 =?us-ascii?Q?qDeXzedu4dYxKAUnNMyUsPI9I5ZNgOl8smMil0wGzYRyfeCkb0SrZnMyyR6m?=
 =?us-ascii?Q?LhA7+fgt08WpqS/NAZuW7ACXzYGPVYHBtICHMhD/8LtFTghh+ICXIcVumUHO?=
 =?us-ascii?Q?kXBgjvR42dbZZH10ZtR5ix/Q83o1DrFge7odGtEiWYFhPL9GtsfsbyzorjmW?=
 =?us-ascii?Q?LsF28VVrgFz/Zlc9ThMNVzAJgKxyXefsVEqa2lSbH9Y6hH/P7Me+ELeC9arE?=
 =?us-ascii?Q?ObVg4/POfv4OkbEGla2d90k1ZMnI2kYe0mFwi5Rqbh98PXPXLJD+EBTKhxhV?=
 =?us-ascii?Q?8qmc8zjU+OpmB5d4C9lm2JAwleN+soFvLryATyaw309X9ioR+9x0svYMRROv?=
 =?us-ascii?Q?1ZLEfE58J4l2GEDfFfERlOjEDbdEChteI/enOXII3SBJIC1AHlzGmq2QgvUy?=
 =?us-ascii?Q?PyyyCSWJFBBgSUAaZRYlAsgUjIbv4+0o5hdrSxzjmDKsgdWf3i2VTsfddY0J?=
 =?us-ascii?Q?ODAG/q+X9RL6+pv3xnHqhh9qQaniHfkCuIbWX6dJGvBxW4VLOT1uPnQUY9q/?=
 =?us-ascii?Q?uc02u29RTzWVR7Dr+GbK8G5jSWadd3ReryhEqlaDFMkFaxlXv17bEbcP1VWk?=
 =?us-ascii?Q?9UcOFL8xdXeLtVwM0fIajbvzzEstKUHWTgVygTrCphmmHD1Isn9jwUOu5ufe?=
 =?us-ascii?Q?qrZmXr6cODK2g4qI3l1Czwktgr5DSOwSXzhVj8c3URT+4P1MP4jdztJuQRrN?=
 =?us-ascii?Q?M0ZXuwcBITEY7Am98hU4s+vvNTgHE24onHtwW8sS6SszO3HRWaQoDxp2Hpso?=
 =?us-ascii?Q?8poK5ExsihKPorGmhOF+4Etn//rbFVYAAiNF1y7YG1y77NqGxwVa/MqXk/z4?=
 =?us-ascii?Q?6gkfgiL6PgAO9gtcK+RNrW8AMcCZtapPzma4jbK+h6B8eObtZUPHiAkdODbs?=
 =?us-ascii?Q?qh16g8dO7fAFj6QUqPmoTpvXEyR96l/QpO0nWEF5/ZSV7CCpUgecAtUp4Z3b?=
 =?us-ascii?Q?uCGK/oB7DT/7RNtCNAK523c/KnJ4RVY8xtSXXuhjKcMP/q7XSusuIsNlGeYE?=
 =?us-ascii?Q?hif3yMFz+McohcusXix5IO40fRmTk0QJiidnYvRcqug46CrqnlDfnf/uGMMs?=
 =?us-ascii?Q?N9om6fiA5EApNwy4iEmvVHCXaBeHKlmaJHd5EA8c2NQ5g2eJVYvEbkUmNxai?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D9F5C9BAB11BAE479FF42F8C0B7916E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4Nq4N5fjR+bVI2gKTmfCYVA1QvSF+trkopxIiCih88heZxERX4WuzS1kUUGMXRsyq9V0SmJMuotT/AhSAEkJ/ezDbqSlRGmsw2bAS2DMHXKULDG6WebELmF9m5uDx57nZFe8QiV+Zoeh0gae7gUYcoLNTYPlTdEPDM+ySAdb4FgBXGfSS0BhWlrHmT3zafZyuZocikzgf4yRISyu9N0kIh7/RCsckknx9BnKVikH1eq4et2wewtBFtghvC26gHKl/gGZYHXPAMmjCPIsiP2Ttm0owpGtQCwWAdGuRShu/Yc1aPZjPaDEMMxFtVCMRliPj/5wh841NnyuvZOJh2a9UnOJhP8IZPdtXPnaScZP5ugQ70u/J2tvjC7cvMZfrfSxcOSUmcp4xsE+R9fXTe4heo4qBvpHcOzARIwVf+Ed/JdknMjdCArmth5C8tMHXwIC1rRm9ePYBOA0Cc7hd8VEmus4va0LmjkFzXgCK8LAuPsSEydKDofqBiVw9CLyqAdXTRJBSpz/BemttMxUn8m8wznTDBexmW7Vy4vqcwqADQ/QdCFynaoqBBb4aZI5wWGEuWIxwINvQ7TzKrXCxKRhkX3dfpgrr9/4bLlw6I44bEfx+8HJpM2rFlrJFZKYaLO7RROSta+0InH94w2HoaxptO03F1vghOq5lpyXJLBHS88SjTthKzCZ8uQFwFFH2QlbhRfUuvZFAzLvvT0OpLduo/lRIVjNsLCuPBAKiIWQ99b1j/z2Rtwpr6UHO2CedyUWi/1GAGc8aTWeCHzv9R67Ty4/84WKwzioBlhuI9qHNY18Mu4ardqu2hyoPfiseu1H
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a6725e-eb95-4b27-3d44-08dbb9209860
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 14:56:24.9228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dyeX757LkIno4qZ0KE8l3WquTXpLpQPBA4yVgUL8X9CqCn6K2aq+xU77FZKnjljEmmmIk2zaJgp7KUObRbtnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190128
X-Proofpoint-GUID: eooAYrapNbNbPo2W_hXPrJH91QzQ2RBM
X-Proofpoint-ORIG-GUID: eooAYrapNbNbPo2W_hXPrJH91QzQ2RBM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 18, 2023, at 8:02 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Tue, 19 Sep 2023, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> There is no need to take down the whole system for these assertions.
>>=20
>> I'd rather not attempt a heroic save here, as some bug has occurred
>> that has left the transport data structures in an unknown state.
>> Just warn and then leak the left-over resources.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> net/sunrpc/svc.c |   11 +++++++----
>> 1 file changed, 7 insertions(+), 4 deletions(-)
>>=20
>> Let's start here. Comments?
>>=20
>>=20
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index 587811a002c9..11a1d5e7f5c7 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -575,11 +575,14 @@ svc_destroy(struct kref *ref)
>> timer_shutdown_sync(&serv->sv_temptimer);
>>=20
>> /*
>> -  * The last user is gone and thus all sockets have to be destroyed to
>> -  * the point. Check this.
>> +  * Remaining transports at this point are not expected.
>>  */
>> - BUG_ON(!list_empty(&serv->sv_permsocks));
>> - BUG_ON(!list_empty(&serv->sv_tempsocks));
>> + if (unlikely(!list_empty(&serv->sv_permsocks)))
>> + pr_warn("SVC: permsocks remain for %s\n",
>> + serv->sv_program->pg_name);
>=20
> I would go with WARN_ON_ONCE() but I agree with the principle.
> Maybe
>  WARN_ONCE(!list_empty(&serv->sv_permsocks),=20
>            "SVC: permsocks remain for %s\n",
>     serv->sv_program->pg_name);
> This gives the stack trace which might be helpful.

I couldn't think of any additional value that a stack
trace would provide over which upper layer protocol
was calling, which is provided by pg_name.



> But=20
>=20
> Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> if you prefer it the way it is.

WARN_ONCE is a more conservative change, so let's
do that.


> NeilBrown
>=20
>> + if (unlikely(!list_empty(&serv->sv_tempsocks)))
>> + pr_warn("SVC: tempsocks remain for %s\n",
>> + serv->sv_program->pg_name);
>>=20
>> cache_clean_deferred(serv);


--
Chuck Lever



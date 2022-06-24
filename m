Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553FD559FE7
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jun 2022 20:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiFXRkZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jun 2022 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiFXRkR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jun 2022 13:40:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1863878C
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jun 2022 10:40:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OHdeAf006125;
        Fri, 24 Jun 2022 17:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Q6RoW+ReH2f47cJIjSy9WsG+0mRwSWO78vOaf9I2dqA=;
 b=z48++OxuPp1RxqiSQZo/lKtJcbu0PKM6WACm5V8hD80EpTLR4RjA0vwc3zyGqLYTuP/Z
 VEMuoFJXL3+ewb8BK7HIA2qvHitYPEIZE3jGNpZl/8PKtl6E47jnCTdHliJwtznQKSMV
 KeBpQQS23GtN8nxNdOPOrUgVhYOHB7oydkONCw6sbNcgYtK75U2W2rzUVSOIotw1sfxO
 JLHUa5zOkFl0Z1M5NUY3QTCZLdMh9aNXhUKgneEQIwFUjiUu+vxU+dV96xC2KPm+7S3B
 z9Wln2OoZHkDpRcg5hA/UD1/LmyFkSH/MFsig8mxHxu5eTlDIHToTgXMOos2fZKZkKoY TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kfe3uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 17:40:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OHKpwt035292;
        Fri, 24 Jun 2022 17:40:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5xkwx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 17:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYUicSaV1II0NN0UnAPWMTJIl21L8kY2WwC1+VVBuw6eora1/Tn4oLyEuOaLj4W3Ml4JSn6Bg+DXbaM1by/kaIWnh+TW0gLz3aWXGllFsIRBgdLhx/K56uUPnGC/96sG2ZnwEbcetoKmMayXtxejPoMoo+psTiLqYJTs0DJwHk/qHG+YwBx1v5bX4zL+Gb6ZPS0Yb7oAl0Cf873DN49UxWWk+gUUHjW+L+S47BSFPkx3+tqWnaFp0ghak4cWSlQNVEhSpBHvntzwnvtjb+XRFzJ0Hcu6n/GeVg0kG3ogqzHAh/dKHLfr/QSVWPYmkTPTZU1qgXqLfpnMkiDZyFWB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6RoW+ReH2f47cJIjSy9WsG+0mRwSWO78vOaf9I2dqA=;
 b=Cqfg9B+zgkJmxsTfuiQf4qacXoH2IPv8ZxwWmdXjCpf6E/3Sbk8aw5qS4Ny3HKipRg0vNqINJnW6NyW/BimC4kZzrjnO7p20lwt3gwNjnj4ff3u7YpmTM+18GkU0YdrFzjLE9oTaadpQ3tNC1nssNVg1NjkIVgc4xZvR6XkIX3Ji1g4D6TOp9fHE1S8AoAHKQv9MzmYNI5qIXI+WVL8r6m/i5vpcXj35YnrlZHybzsawgPYHN3SBpMGnEabh9FqLoM9wk5dYSIbKF/Jy5DFSt+yPI+W0acN7PzbhqzW6GBMpzcSjjAiCjb1R6JM4voRwcYvZWsIIHAcCS4a17pPZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6RoW+ReH2f47cJIjSy9WsG+0mRwSWO78vOaf9I2dqA=;
 b=Wo+yoh8GynrugL2xtPdPkLw3ih8a05gT6Rr2kc20KWV9lGAwX8i3PfHm+Aq77a9oztaGSW+Vib0/KEhSNmjNApaXCFEVtabPz8+r2hLdrkaUvX7QJrsJuealyQTsq2YyF4VF18xWDDnLwuZkiKyGvUqBMFZyCEiT56U/47icc/E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR1001MB2084.namprd10.prod.outlook.com (2603:10b6:405:2d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 17:40:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 17:40:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>
Subject: Re: [PATCH] NFSD: Don't continue encoding if READ_PLUS gets confused
Thread-Topic: [PATCH] NFSD: Don't continue encoding if READ_PLUS gets confused
Thread-Index: AQHYh+HAA8+QSbxkgUGPQSaEnGmW5q1e0x+A
Date:   Fri, 24 Jun 2022 17:40:08 +0000
Message-ID: <B809231A-ACDE-4D97-B866-F969B08AA7EC@oracle.com>
References: <20220624154737.1387850-1-anna@kernel.org>
In-Reply-To: <20220624154737.1387850-1-anna@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 713e699b-100e-4fdc-d670-08da560894cd
x-ms-traffictypediagnostic: BN6PR1001MB2084:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PjkU+w3uCPPV6rbySe4sjLF6kCOgfn/ieRMRcm5VodRosxFg8wk+1K5+Ct4d5Xlf8OnhobmFmgwMmyKjmtUAIMWdpW03rnU8miyiDCnoY2TxK98/8o/OFwzn7jKgjOLEC3tttXJ/LV//LCIOuEsmm4QaOOgdBHVvEu11CS8VXVuteyBZZbHlwRl520W8RTB1a3mx60/PiGjgUkzJkKYgoovFidDpxXG+GI7rhaPvloepPMzpbuaP/faCMNnGxWkb5RdecQVpYPrmR1VyUq90YIZA2SruplpAaO1oiP79w81tLwwKg9lLfsTR2kVTAjjaTtPHgEIn+s6zSjYEObKf2An42Qn9UqjJto8TmEfSQ54sf+jtvIEZ8d0ZPZ4Wzi+oq83qAplMBJDgwVq7LTKF+7Sevdf1k+ffkB4AMaHVp7x1RAyuhS7ZtyHClcI/K7R1h4cAVYnM7JHL6d0SAGLZNSTrZaMeEsahqrFxy3CRmgdHhmHVRMAj4qmU/fqAD/wjvyj3Db1WBcomloM1q3x1p1FSkMH1Wg4WL7SrV+bnbB87tiun0NXhJogHtuLghkJMXV8EdTGhCZ2HDUUaDrDUZrHgANlhqF1oxOYWOgw2GBVyidTftnLbF0DtjUFT/D03s9f3ziNcgpU73ACBqm2h/m2ALRBPnSupIKriKpvtmnZ1oV5Gd696Owdjsyu3c0pKZOACofWfmNgtFoBAjfyXyNkudtgchrmJFuXzBC76JXt1TcCMVAmlaigdyix9LVwJA16PlDul/3quQqhmHla1IVtrR94pFMzQSNI33RKyTvZyZAusb226hWyIo65nyxfEdGvU9L+eN1yaSWyyB4MTWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(136003)(396003)(366004)(186003)(38100700002)(2906002)(53546011)(4326008)(6506007)(316002)(122000001)(36756003)(76116006)(83380400001)(41300700001)(8936002)(2616005)(33656002)(38070700005)(66476007)(66556008)(478600001)(66446008)(64756008)(5660300002)(91956017)(6916009)(54906003)(66946007)(86362001)(8676002)(26005)(6486002)(71200400001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/bL8yQ8BZy5WXgWjLSV7z7fo+m1Ll12YaIYRmaMymOcgKAWsSNR98Vp8CWdn?=
 =?us-ascii?Q?8SSyV80aSPXDziMxQ+LzzYKZIIe4UZWp/l4LfGvLYkm2BQF9Iu+RLMumnBdp?=
 =?us-ascii?Q?fdvnX+1pJB0HUeIN8A5LPsDuDzfM33DYO/89koXL6qTuy0kgQAtJtHG9P+pV?=
 =?us-ascii?Q?MkfF/yLZTvRwL9hd8LbXVE7JLkgXLv0JuE63lBI+v8H6eexMj7ZdHntvbrBo?=
 =?us-ascii?Q?DHyczeMN/mZsYoQOeYz7vymmZmdBbwKNt09BiRu1f7TEA04JubXjhUd5GArQ?=
 =?us-ascii?Q?juUcCXyUlUk7tR+eXkyqCBzx9z+HRzmDb6ncDW8uLnX5Gk3GfIu1xhX76khJ?=
 =?us-ascii?Q?+lh35+uALtBnNlccSBzEWvzoK11xqYy9BseUZW54Ws1GZlijTwMn/lDySQSC?=
 =?us-ascii?Q?UsnDFW1tIvrObNtkp2XbJB64cWJO4iPJCdZIZMP9y9np+DdATfTVTwOtzlOG?=
 =?us-ascii?Q?22P/4S0+Ei8nbTARDIzP4XXrd4fiAhcKye8JMdVoRVOzyIHP97p4F6oiH3oL?=
 =?us-ascii?Q?UNmU6nbHoZYJ8IutZRn2nz380b0B7umku2eg7q3/AwDWnDskeqZJqpgDmorG?=
 =?us-ascii?Q?AmWMyYTE06RG3Paq3gNM7rbDHAitsCF/0fHPMAIN3tL672jelnYan3X8gIxQ?=
 =?us-ascii?Q?pH2e3obumfhAgZPQP2jesIVz6IWJ42D+EiONaCVLNhleopRQno30uOHbaW0n?=
 =?us-ascii?Q?Or348C/bGj0nfvyRKF3smG8ML3nQ21ielI/XiEonfVfrVYyANVwCRsepaG8D?=
 =?us-ascii?Q?9v7WPQSUjo2o7JevVpiS6LMKOgIMQpUyr/qfkqTKEIw0GEk9bUcLcXjuCD8T?=
 =?us-ascii?Q?QwpEqqaAW2XCC3Uiven8woBLn8HFXgxlZaarnVlQwEceGc++CavHCbhoYmFV?=
 =?us-ascii?Q?FBnOuroHemB5Uc78Pk8SxLIYuPJMrPVpFDvZmMD+1bLhSo7mxugU6dbXf2t6?=
 =?us-ascii?Q?1cxaRUcR0e4fgKJIjCSomEPHeBYC7Z8+tr9wWBoBTQcPpliisyv6KYVTZmz9?=
 =?us-ascii?Q?IsGQ0AeYIXgFUxlDJ9qqvKXx3HHFTjDXJ3ekeOGAsGgzkdg0RBB4spFW1WmL?=
 =?us-ascii?Q?R3q2uZC+0OsfapsjzOifYKfxuhBO62ra6s8pDXrqMOfcfqA7y8K4ZK31N78k?=
 =?us-ascii?Q?mEFVEt9BBO2tsuY29JmnJyaNXcmHVNnPVFLQYtzLQ9zuYeXnsARKUa3JzIwi?=
 =?us-ascii?Q?DgTop2Hl5PB+D8FV7JIO0MO1FtA+zioJwPOvJiVedS4Dn5GjtdUIqhzC9l+g?=
 =?us-ascii?Q?2iMXJKWATHW4AQdnrzUo827P1lUTuwcOSt3rgwFXoNxrZAj+iijdFq6eU3k/?=
 =?us-ascii?Q?G3YTbgZU5S1ej61THeDmIG6aTPeoIFlwjr6DlB2Ekxrq95fyU1X3oDxUZmMz?=
 =?us-ascii?Q?XdJNFAaeNa1TcOgVC9Rv1d2CQPF+JcOYrPFjsfCCqPEUSvjdVTCmbBQG/Hhm?=
 =?us-ascii?Q?n8jRaw8wUAgzchU+NNOFdw5ICbPVEFgjon45OV6ZPulYtXtKTiDrqnhDDzvp?=
 =?us-ascii?Q?TTnaNykRn7galWEgE8+u7kqa1ciXc+uJ0/+moxjv8YMJtbv3OMcR8XO+CXFZ?=
 =?us-ascii?Q?+UhH3OuND57jNg1hycQFAV82I75kdj7YH4ZtW5kB/SPTw9SS+ALAF6l620xv?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E4EADDCE0F31D4595D0BD8CFD332E31@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713e699b-100e-4fdc-d670-08da560894cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 17:40:08.2122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qildBAfqhrLYnt3jYV0SomatexW96ESf1WQxkAPW67pBbLf3VWwE8StlDLzSfuNkD3DVCIYMupSn/S9vwvGizQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2084
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_08:2022-06-23,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240067
X-Proofpoint-ORIG-GUID: fY6ZQiTNfAKkGKnTHihcQSmyyTpTIFai
X-Proofpoint-GUID: fY6ZQiTNfAKkGKnTHihcQSmyyTpTIFai
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna!

> On Jun 24, 2022, at 11:47 AM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> If we were in a HOLE segement, but vfs_llseek() claimed we were encoding
> DATA then we would switch over to the DATA encoding function. This
> conflicts with Chuck's latest xdr cleanup patches and can result in a
> crash or silent hang. Let's just return nfserr_io if we find we are in
> this situation, which will cause the encoder to return to the client
> with the number of segments already encoded. The client can then try the
> READ_PLUS call again.
>=20
> Fxes: 6c254bf3b637 (SUNRPC: Fix the calculation of xdr->end in xdr_get_ne=
xt_encode_buffer())

checkpatch complains about this tag.

Also, Bruce said he wasn't able to reproduce the issue on
6c254bf3b637, only on the whole series. Were you able to hit
it with just this commit applied?


> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

I find this somewhat problematic. I can't apply this patch in
good conscience:

* The usual guideline for applying a workaround upstream is
  that there's been a demonstration that it will be impossible
  to find and fix the real problem. I don't see that here.

* We still don't understand the failure. The XDR code itself
  might be broken? Therefore we don't understand if this
  workaround is 100% effective

* Usually with a workaround, there's a hint of a long-term
  fix... is this the long-term fix?

In other words, I might give this patch to a customer who
needed to get back on her feet quickly. I'm hesitant to take
it as an upstream change without further justification.

IMHO a fix in an XDR consumer (like READ_PLUS) needs to
demonstrate that the current XDR code is working as designed.
Otherwise, the XDR code itself is what needs to be fixed.


> ---
> fs/nfsd/nfs4xdr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 61b2aae81abb..dc97d7c7e595 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4792,7 +4792,7 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundre=
s *resp,
> 	if (data_pos =3D=3D -ENXIO)
> 		data_pos =3D f_size;
> 	else if (data_pos <=3D read->rd_offset || (data_pos < f_size && data_pos=
 % PAGE_SIZE))
> -		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size)=
;
> +		return nfserr_io;
> 	count =3D data_pos - read->rd_offset;
>=20
> 	/* Content type, offset, byte count */
> --=20
> 2.36.1
>=20

--
Chuck Lever




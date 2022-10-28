Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB046611280
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJ1NQ1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 09:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJ1NQ0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 09:16:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75045993A6
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 06:16:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNnSu030166;
        Fri, 28 Oct 2022 13:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=E/qYAfHlaKbkkhUP8XbLemtDJrRzVtywjF8npvOWzU4=;
 b=oSKS2/G6EHCjWi9lC0aCsUPOpt3OALPBzaaotDdc2DmOpDL0LNmPNMoP4rB1HnxsSdOK
 kH9C/q75LU7DmwLp58OfM3K3p0+upp00GnFIaqiCoxc+DpWGEckxoWZDl195Px6aTDvB
 A3vtAnwwUU7kZnfhsCO4TkhYGNNTWgMeTqg2gruq/HOFIvv8OGbuDRdcvyecH2RNBlKO
 0Bi0radqfbfz8uFkYF8k75l0jCnTNOa+grtUzEMjYXC61/3+HsGO252bcgXLDJlTxAti
 01WEBhJugiHtYTBmqyPiW9O/CV62s1mlpiE8wIilN5LWm5Ghr6cIXdr/fMhXXVE2rAD3 vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv52t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 13:16:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SB6t7v006963;
        Fri, 28 Oct 2022 13:16:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagj22c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 13:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iceBkoMbUyQwwGKnB+Ez1Mt/1wGSyFWiVwC17QDFkvc8SKO5HRiRvM/8tfyNUlaZKB8Y4zC2je49/VoZY3NljPhFzYk0yELGkzUnsYJY5zvc4XFdpNtluOx2XSgLJyZ5aBe9C2J1y9powjscBnb6icqD6gu5i3cU4xgM6IeigbAshmo1PNjNhENhQjwAM+YhDEf/Ppui3ENKIcLsn3k+NazTEsdv9p4x/SVccXmR8ujmZhkiwKofgoRIRTAbbKHwNefAEDXWXdDFXmjLsjL8vzAbYcSQIVgeAQMoosWkEmlu5TOGe/dcnxKceNd6AIdiLGJVe7g2PlDn9LuRh56j8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/qYAfHlaKbkkhUP8XbLemtDJrRzVtywjF8npvOWzU4=;
 b=k/Vy4gu5sMc0o/SekaTvPJe52wfBHUQLeHBBVqmVq06Rcv2w+YY8pakfCcNj3ZuvyV5aEYTzUeBMlzwtqkuTwbyFRzo0Kiuab5/SaZ2rhxqBd4GSCB8s41MHD7bafqr5W/udvglPPVL9RAfi6Ef7/kaKy88YwV0b5YellmB0YJVnTjvAv5xV4XnRlvL7EbX/UTHi0JZRnK/cH0tF6TC3gJAzhslT6HUyugMX1al/iuJeVAEhRXm12sYkhw5fxAPKuiRbyUuHQsXBOx0j809kkcxPwlhjGq25psI1zRe7Dag4/e/umz49eQlIWAfn94STivnV03OcG/I9RJhS2MWNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/qYAfHlaKbkkhUP8XbLemtDJrRzVtywjF8npvOWzU4=;
 b=ZYoc0gmjt7vSJnoGYpNP2KPXcdjYznnAaH6mKKppGSKw4MfCnkYO3OIV+NQkklMJSaEb6v5GxaWe5P8kx4ElPOuR9pLebkhqhhQwyauJCb1Utklh6VVwmZYn5tQ+jhTEJBqkr83DJxpjkf+asA7yMl69pVV1BGmMvZS9beJeKIA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4690.namprd10.prod.outlook.com (2603:10b6:303:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 13:16:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 13:16:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Topic: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
Thread-Index: AQHY6k5k3iaHcLvdwUOL1QTSt6QmjK4jykqA
Date:   Fri, 28 Oct 2022 13:16:13 +0000
Message-ID: <D32F829C-434C-4BA4-9057-C9769C2F4655@oracle.com>
References: <20221027215213.138304-1-jlayton@kernel.org>
 <20221027215213.138304-4-jlayton@kernel.org>
In-Reply-To: <20221027215213.138304-4-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4690:EE_
x-ms-office365-filtering-correlation-id: e898fefb-e8b5-47e3-f647-08dab8e696bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XvZPjE+BVSYlk2Jvmc/btbK/9p1EsxGalrQgZ2JYkaDoKuc7o6htXuK+BLGD626JaOmGco5K5gHyFV8w+dyxr/YAcHmfEjNC5L/OybKwWeaWfo3R6NhUj/EBdPnVXW/WyOoQXq9JdJsRJIEZ2deyBAHTes0qcyWX/KLptYUohgh3Rhr/r/52sqwEFOCPybmIAzPuGMyNbpydhNnCMd3lMy/I+QDUcDqaITA0Vxif8H7YJMQ6aTdDNhDlKMb79JF1Fp3/UMHl57qPP43gCE0TVU4oDxGMZBsMERia/sHUCjVZd3kR/CeY0wN3UCOmi4bX1VOF6X9RJ+3vO51eX7pgjQLuPDbeZdNCbwJV3XqEqy7qTKombb2Cmnoyl/FNg8fs3IBYLyjoxnc2qduddy/W3C9//oEE6kMkR6uJJSI4LOvddXCC9bNDJF7ku+gOyzKNd7p441mqM5jZaX+itOjeSYmF58GwSx+z/30DSxbiiAo596sK9k5K1SLrHcAQxMAqXLuK5hc+0k0UwmbOIQDzx/n2xL+9vbJr6QaKAVPd7V4j/lKgRG4CHnhLHsR3oPg36p7s+XSVhUP2a0EIa4SU9VovFxQmj630QILoLfNbZ08hhLybpWkO0E0uPUVF+KSyHiHLZVV1MBOODoyK5aO9LOY7FGDALtjdJsMHl5lvykKC8qqi0Qoa8v4PoGQkoygAEcP+IPdoCUtvzQOBhHmeHtag2dn0bKIHz4XS07FZnfLRSi8atwqx6aTvjQVWSv9DwLxaHUPXYBGlUoRfL+TXEJfOG3VPx5ZGI4pf3EfHe3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(83380400001)(86362001)(38070700005)(33656002)(38100700002)(122000001)(2906002)(5660300002)(66946007)(4326008)(66556008)(66476007)(66446008)(64756008)(8676002)(76116006)(41300700001)(6916009)(8936002)(6506007)(26005)(2616005)(186003)(6512007)(316002)(54906003)(91956017)(53546011)(6486002)(71200400001)(478600001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PsjkyfaK3FaIgk6AHLE523KHgmP8KeRjDanET/227aAPPeaZ4L+yciqzW82f?=
 =?us-ascii?Q?O0VXx8Ae7kvY7q3XKeWuQjXiwWDSUX7/hDJNN3vstOmIdHWVuIRWXWAJoQig?=
 =?us-ascii?Q?LQ05vANHFIDaA+jVOfSlt0sDwD2rZCQaael3//5BgsBLYeOOuLaz0MxNKhfQ?=
 =?us-ascii?Q?Bn9IIzS7npOw1GUi358j4c5+vdPyF95MzUSbGliuq9IBY9i0QquSbLgzqQoZ?=
 =?us-ascii?Q?t4VhcMS9HEr3RbRvNSM4cCo4AgjSHTrUqGIdDbNzOPgJpI8LihhEY+PFxVPE?=
 =?us-ascii?Q?X3gpS3bEylGKo19bqRO1fGrUa++ogyOBoC6GkrcTJg92CTYxoIl60lywdjpJ?=
 =?us-ascii?Q?Pe57r05F8fhMBpT3CcnCff0ty1TNFnXnV3c3vNV2ZZKh2jesW1ZDS2GzYVW/?=
 =?us-ascii?Q?9k6PZ1M9eh8tvTXXT7WxIi3vHoZD3p7tedsytVBDRxRjfQwoH46102B3GXtV?=
 =?us-ascii?Q?nwBXqepF36O/LFQBzo8kMmoiwjVD6VnOStCBZTI1HT1N30D4AGDhgIEfTWIP?=
 =?us-ascii?Q?FcOKWF4pSvEHreO6j1lRtEIWjk5UX3yRlGdUzmQlgvs+V1sCz+3cF2+Uok8Y?=
 =?us-ascii?Q?OKo5qsCaywC7a40PoFsa1hoHd4wUceBuZdtyDkAZvirtpTE2tf/+NIN6Y/y1?=
 =?us-ascii?Q?3z+paj2SWHfXjnVSjzrPCqt1P2yyP+iHBQFzfH5WXEtn16DxsQ+wyRe55SYq?=
 =?us-ascii?Q?KGQ4J19GnvRrPQXbsUej6HgUormF3Elm+e2Q9VVlZePQwZQcnLuTCMTn9wR9?=
 =?us-ascii?Q?MvNLTE2WYWTZuqfAJfs4AFxZTSY+nNqCXKrLUkpmHlUuqbNQ81NO3ak+ZsZI?=
 =?us-ascii?Q?RlAU6tNA10jZgYOlDSUAD/V43eCU0zTibcoR/AmHriQzeZtjwnQJTeykzM9E?=
 =?us-ascii?Q?DERRR+cueTDRzP9jyzuAWvv7Mg6xOwfiHRcMd6+56V9kIlF8IfXYpbxRoRBy?=
 =?us-ascii?Q?kor38RVYT0xaTodA7vIFNrEsb13QaCFyAmzxb28LWQ+Ht8BioIJ3Os/0n15G?=
 =?us-ascii?Q?QlxO5kmAskGFcWVl7tRohnJ5pK+MpkXOgbHRONvetDVuQF7UNbDbFwZhNYAn?=
 =?us-ascii?Q?0yCJlmoV0et6luaXAuHezxp3AMqW1DahlmHI0b7KWht4GFIqeZcyvUgREE4m?=
 =?us-ascii?Q?ITgzaIVjLapwLj9+J1YGeMJv6g66He64R5xngy+WVTJ1LxLb1NGEJEjlWt5Y?=
 =?us-ascii?Q?RR2hHWaxr1tnwNNHY5EGUfbKxSdvKEYmUFkJzAKeQKNmM0jnHWW1NQmn08mz?=
 =?us-ascii?Q?IEWMVqz0JxtbS7uUg7hrc/CpXpyAd3d7j8qnW4ODfDEEo1AKDXuxESoUZP7i?=
 =?us-ascii?Q?ag9v8cQNj64mdmqMeTD3EQFNCn1nGQl7Fqo1x1vlw0iYgcs4779TRsHfaUfh?=
 =?us-ascii?Q?onymq+JkVyk6XFOZT+QCsFJ8xijEHJtvp8Q65l25FqOCU+KSN5wKMew8Zeds?=
 =?us-ascii?Q?txSCyW465i1n+fI4m/WEnLeXImYfZ7pnKfqaTxK3+vusI+04zAAO5G9QIB+s?=
 =?us-ascii?Q?CmCgJFdtVDHEnklVNTsUHkmfvBWmLoPaFjZhO5MS9iSpQ/uVFwc+btmkwJ9v?=
 =?us-ascii?Q?XjWzpuuYAUtrKMgSYQeRgllL4ZfgI983OyXe5oFwvUHJjommLG1PQkw5Rqth?=
 =?us-ascii?Q?TQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5036219AADA97447A054925E5983364D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e898fefb-e8b5-47e3-f647-08dab8e696bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 13:16:13.6742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08sg5yalndYplBRMnHBgl6RNsQvFcecwvj9HxjR8c/HGgasfk9dVMu+12HcAMy33lUeUM9xh7BK+ouHJhhXoMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_06,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280082
X-Proofpoint-ORIG-GUID: LC2M57yQ6Zb9uJiAWDCJVB5aU1BGnj72
X-Proofpoint-GUID: LC2M57yQ6Zb9uJiAWDCJVB5aU1BGnj72
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 27, 2022, at 5:52 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
> so that we can be ready to close it out when the time comes.

For a large file, a background flush still has to walk the file's
pages to see if they are dirty, and that consumes time, CPU, and
memory bandwidth. We're talking hundreds of microseconds for a
large file.

Then the final flush does all that again.

Basically, two (or more!) passes through the file for exactly the
same amount of work. Is there any measured improvement in latency
or throughput?

And then... for a GC file, no-one is waiting on data persistence
during nfsd_file_put() so I'm not sure what is gained by taking
control of the flushing process away from the underlying filesystem.


Remind me why the filecache is flushing? Shouldn't NFSD rely on
COMMIT operations for that? (It's not obvious reading the code,
maybe there should be a documenting comment somewhere that
explains this arrangement).


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 37 +++++++++++++++++++++++++++++++------
> 1 file changed, 31 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index d2bbded805d4..491d3d9a1870 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -316,7 +316,7 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, uns=
igned int may)
> }
>=20
> static void
> -nfsd_file_flush(struct nfsd_file *nf)
> +nfsd_file_fsync(struct nfsd_file *nf)
> {
> 	struct file *file =3D nf->nf_file;
>=20
> @@ -327,6 +327,22 @@ nfsd_file_flush(struct nfsd_file *nf)
> 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
> }
>=20
> +static void
> +nfsd_file_flush(struct nfsd_file *nf)
> +{
> +	struct file *file =3D nf->nf_file;
> +	unsigned long nrpages;
> +
> +	if (!file || !(file->f_mode & FMODE_WRITE))
> +		return;
> +
> +	nrpages =3D file->f_mapping->nrpages;
> +	if (nrpages) {
> +		this_cpu_add(nfsd_file_pages_flushed, nrpages);
> +		filemap_flush(file->f_mapping);
> +	}
> +}
> +
> static void
> nfsd_file_free(struct nfsd_file *nf)
> {
> @@ -337,7 +353,7 @@ nfsd_file_free(struct nfsd_file *nf)
> 	this_cpu_inc(nfsd_file_releases);
> 	this_cpu_add(nfsd_file_total_age, age);
>=20
> -	nfsd_file_flush(nf);
> +	nfsd_file_fsync(nf);
>=20
> 	if (nf->nf_mark)
> 		nfsd_file_mark_put(nf->nf_mark);
> @@ -500,12 +516,21 @@ nfsd_file_put(struct nfsd_file *nf)
>=20
> 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
> 		/*
> -		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> -		 * it to the LRU. If the add to the LRU fails, just put it as
> -		 * usual.
> +		 * If this is the last reference (nf_ref =3D=3D 1), then try
> +		 * to transfer it to the LRU.
> +		 */
> +		if (refcount_dec_not_one(&nf->nf_ref))
> +			return;
> +
> +		/*
> +		 * If the add to the list succeeds, try to kick off SYNC_NONE
> +		 * writeback. If the add fails, then just fall through to
> +		 * decrement as usual.

These comments simply repeat what the code does, so they seem
redundant to me. Could they instead explain why?


> 		 */
> -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> +		if (nfsd_file_lru_add(nf)) {
> +			nfsd_file_flush(nf);
> 			return;
> +		}
> 	}
> 	__nfsd_file_put(nf);
> }
> --=20
> 2.37.3
>=20

--
Chuck Lever




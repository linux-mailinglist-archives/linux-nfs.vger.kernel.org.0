Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34DD111240A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2019 09:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLDIAx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Dec 2019 03:00:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35774 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDIAx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Dec 2019 03:00:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB47scO2133950;
        Wed, 4 Dec 2019 08:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=27nOwWCWFO4zI5K8WCpBd+uSHd1eh70AglJSN4StBoY=;
 b=h4lze+rIJKTHmRC2OYz8wG9+xV4ffWsiifMBpnHFGclznQDKG+scfQ1+5G2zjpOBlpev
 lsvsbClK1r0wYbIE9FXO3V38ew4GzEjtnLKAg9PKQTilDz4Qrp7k+IyNTBOIjVLfEFRK
 H0V0T5/htJ78dyZzYUQmHTWbkbqYV+f29eexKWhtCCUuZJwA6w0+ybEacKbrE0WQKGrX
 dgANrbMhnABxJUH56TxB+O6WyqTMg1RHOMc37dw3HsNX1kiAZ2i7gNn5cG3JqjDHL1dc
 DYx97W5865kBMwBVws5Vg05MkIC04fX9Fg3LIQSE3eJYHibpAZ/kuompda2LYjQChK7d 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wkfuucv8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 08:00:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB47whS3074163;
        Wed, 4 Dec 2019 08:00:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wp169t1vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 08:00:49 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB480lMT028576;
        Wed, 4 Dec 2019 08:00:48 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 00:00:47 -0800
Date:   Wed, 4 Dec 2019 11:00:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] NFSD: allow inter server COPY to have a STALE source
 server fh
Message-ID: <20191204080039.ixjqetefkzzlldyt@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=486
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=537 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040058
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Olga Kornievskaia,

This is a semi-automatic email about new static checker warnings.

The patch 4e48f1cccab3: "NFSD: allow inter server COPY to have a 
STALE source server fh" from Oct 7, 2019, leads to the following 
Smatch complaint:

    fs/nfsd/nfs4proc.c:2371 nfsd4_proc_compound()
     error: we previously assumed 'current_fh->fh_export' could be null (see line 2325)

fs/nfsd/nfs4proc.c
  2324				}
  2325			} else if (current_fh->fh_export &&
                                   ^^^^^^^^^^^^^^^^^^^^^
The patch adds a check for NULL

  2326				   current_fh->fh_export->ex_fslocs.migrated &&
  2327				  !(op->opdesc->op_flags & ALLOWED_ON_ABSENT_FS)) {
  2328				op->status = nfserr_moved;
  2329				goto encode_op;
  2330			}
  2331	
  2332			fh_clear_wcc(current_fh);
  2333	
  2334			/* If op is non-idempotent */
  2335			if (op->opdesc->op_flags & OP_MODIFIES_SOMETHING) {
  2336				/*
  2337				 * Don't execute this op if we couldn't encode a
  2338				 * succesful reply:
  2339				 */
  2340				u32 plen = op->opdesc->op_rsize_bop(rqstp, op);
  2341				/*
  2342				 * Plus if there's another operation, make sure
  2343				 * we'll have space to at least encode an error:
  2344				 */
  2345				if (resp->opcnt < args->opcnt)
  2346					plen += COMPOUND_ERR_SLACK_SPACE;
  2347				op->status = nfsd4_check_resp_size(resp, plen);
  2348			}
  2349	
  2350			if (op->status)
  2351				goto encode_op;
  2352	
  2353			if (op->opdesc->op_get_currentstateid)
  2354				op->opdesc->op_get_currentstateid(cstate, &op->u);
  2355			op->status = op->opdesc->op_func(rqstp, cstate, &op->u);
  2356	
  2357			/* Only from SEQUENCE */
  2358			if (cstate->status == nfserr_replay_cache) {
  2359				dprintk("%s NFS4.1 replay from cache\n", __func__);
  2360				status = op->status;
  2361				goto out;
  2362			}
  2363			if (!op->status) {
  2364				if (op->opdesc->op_set_currentstateid)
  2365					op->opdesc->op_set_currentstateid(cstate, &op->u);
  2366	
  2367				if (op->opdesc->op_flags & OP_CLEAR_STATEID)
  2368					clear_current_stateid(cstate);
  2369	
  2370				if (need_wrongsec_check(rqstp))
  2371					op->status = check_nfsd_access(current_fh->fh_export, rqstp);
                                                                       ^^^^^^^^^^^^^^^^^^^^^
Is it required here as well?

  2372			}
  2373	encode_op:

regards,
dan carpenter

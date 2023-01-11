Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712A0665B6C
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 13:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjAKMeA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 07:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjAKMdz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 07:33:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0C9FAE6
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 04:33:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D4BD61CC6
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 12:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952AEC433D2;
        Wed, 11 Jan 2023 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673440433;
        bh=ZDKOdyYJNe/hcvwgYO1QNd0/BMggoroNwD4hPCz52Mc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S9gc2PjZ7q2vTO/BEE3PKPD+aAM0fqP2FkDptnPy6CGhkKX/ZUmJY0B5h/fH8Cir1
         H08N178brHlT/+afnvQzBXzRylAb42olz+f3iy9UyKG4sluiPR1C5geAe4GC0cAaC4
         w7lQqlXfF/NEXpqmzjZzUwygJVWppP+6pnUqvBo+MtXVtDhVWxC7ZI1qHjC/DGrAWn
         q4BSOx5RwL5mC5WWBpQyUL71EpnjPsa74MguP0stWppubxlYBQ4GWdO9E0e8H8vHzH
         iP5NZx0qXFcArxfCu76LjPYf8DPJ8MEhkMeaUt2VFx0rk/5THL6kwkvGN9seBHsJsZ
         Br9PI+QhxVyPw==
Message-ID: <5f43a396afec99352bc1dd62a9119281e845c652.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Jeff Layton <jlayton@kernel.org>
To:     Mike Galbraith <efault@gmx.de>, dai.ngo@oracle.com,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 11 Jan 2023 07:33:51 -0500
In-Reply-To: <fe19401301eac98927d6b4fc9fbf9c8430890751.camel@gmx.de>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
         <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
         <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
         <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
         <8e0cb925-9f73-720d-b402-a7204659ff7f@oracle.com>
         <37c80eaf2f6d8a5d318e2b10e737a1c351b27427.camel@gmx.de>
         <ce3724b88bb2987ac773057f523aa0ed2abacaed.camel@kernel.org>
         <2067b4b4ce029ab5be982820b81241cd457ff475.camel@kernel.org>
         <ec6593bce96f8a6a7928394f19419fb8a4725413.camel@gmx.de>
         <fe19401301eac98927d6b4fc9fbf9c8430890751.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-11 at 13:15 +0100, Mike Galbraith wrote:
> On Wed, 2023-01-11 at 12:19 +0100, Mike Galbraith wrote:
> > On Wed, 2023-01-11 at 05:55 -0500, Jeff Layton wrote:
> > > >=20
> > > >=20
> > > >=20
> > > > It might be interesting to turn up KASAN if you're able.
> >=20
> > I can try that.
>=20
> KASAN did not squeak.
>=20
> > > If you still have this vmcore, it might be interesting to do the poin=
ter
> > > math and find the nfsd_net structure that contains the above
> > > delayed_work. Does the rest of it also seem to be corrupt?
>=20
> Virgin source with workqueue.c WARN_ON_ONCE() landmine.
>=20

Thanks. Mixed bag here...


> crash> nfsd_net -x 0xFFFF8881114E9800
> struct nfsd_net {
>   cld_net =3D 0x0,
>   svc_expkey_cache =3D 0xffff8881420f8a00,
>   svc_export_cache =3D 0xffff8881420f8800,
>   idtoname_cache =3D 0xffff8881420f9a00,
>   nametoid_cache =3D 0xffff8881420f9c00,
>   nfsd4_manager =3D {
>     list =3D {
>       next =3D 0x0,
>       prev =3D 0x0
>     },
>     block_opens =3D 0x0
>   },
>   grace_ended =3D 0x0,


>   boot_time =3D 0x0,
>   nfsd_client_dir =3D 0x0,
>   reclaim_str_hashtbl =3D 0x0,
>   reclaim_str_hashtbl_size =3D 0x0,
>   conf_id_hashtbl =3D 0x0,
>   conf_name_tree =3D {
>     rb_node =3D 0x0
>   },
>   unconf_id_hashtbl =3D 0x0,
>   unconf_name_tree =3D {
>     rb_node =3D 0x0
>   },
>   sessionid_hashtbl =3D 0x0,
>   client_lru =3D {
>     next =3D 0x0,
>     prev =3D 0x0
>   },
>   close_lru =3D {
>     next =3D 0x0,
>     prev =3D 0x0
>   },
>   del_recall_lru =3D {
>     next =3D 0x0,
>     prev =3D 0x0
>   },
>   blocked_locks_lru =3D {
>     next =3D 0x0,
>     prev =3D 0x0
>   },

All of the above list_heads are zeroed out and they shouldn't be.

>   laundromat_work =3D {
>     work =3D {
>       data =3D {
>         counter =3D 0x0
>       },
>       entry =3D {
>         next =3D 0x0,
>         prev =3D 0x0
>       },
>       func =3D 0x0
>     },
>     timer =3D {
>       entry =3D {
>         next =3D 0x0,
>         pprev =3D 0x0
>       },
>       expires =3D 0x0,
>       function =3D 0x0,
>       flags =3D 0x0
>     },
>     wq =3D 0x0,
>     cpu =3D 0x0
>   },
>   client_lock =3D {
>     {
>       rlock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D 0x0
>             },
>             {
>               locked =3D 0x0,
>               pending =3D 0x0
>             },
>             {
>               locked_pending =3D 0x0,
>               tail =3D 0x0
>             }
>           }
>         }
>       }
>     }
>   },
>   blocked_locks_lock =3D {
>     {
>       rlock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D 0x0
>             },
>             {
>               locked =3D 0x0,
>               pending =3D 0x0
>             },
>             {
>               locked_pending =3D 0x0,
>               tail =3D 0x0
>             }
>           }
>         }
>       }
>     }
>   },
>   rec_file =3D 0x0,
>   in_grace =3D 0x0,
>   client_tracking_ops =3D 0x0,
>   nfsd4_lease =3D 0x5a,
>   nfsd4_grace =3D 0x5a,

The grace and lease times look ok, oddly enough.

>   somebody_reclaimed =3D 0x0,
>   track_reclaim_completes =3D 0x0,
>   nr_reclaim_complete =3D {
>     counter =3D 0x0
>   },
>   nfsd_net_up =3D 0x0,

nfsd_net_up is false, which means that this server isn't running (or
that the memory here was scribbled over).

>   lockd_up =3D 0x0,
>   writeverf_lock =3D {
>     seqcount =3D {
>       seqcount =3D {
>         sequence =3D 0x0
>       }
>     },
>     lock =3D {
>       {
>         rlock =3D {
>           raw_lock =3D {
>             {
>               val =3D {
>                 counter =3D 0x0
>               },
>               {
>                 locked =3D 0x0,
>                 pending =3D 0x0
>               },
>               {
>                 locked_pending =3D 0x0,
>                 tail =3D 0x0
>               }
>             }
>           }
>         }
>       }
>     }
>   },
>   writeverf =3D "\000\000\000\000\000\000\000",
>   max_connections =3D 0x0,
>   clientid_base =3D 0x37b4ca7b,
>   clientid_counter =3D 0x37b4ca7d,
>   clverifier_counter =3D 0xa8ee910d,
>   nfsd_serv =3D 0x0,
>   keep_active =3D 0x0,
>   s2s_cp_cl_id =3D 0x37b4ca7c,
>   s2s_cp_stateids =3D {
>     idr_rt =3D {
>       xa_lock =3D {
>         {
>           rlock =3D {
>             raw_lock =3D {
>               {
>                 val =3D {
>                   counter =3D 0x0
>                 },
>                 {
>                   locked =3D 0x0,
>                   pending =3D 0x0
>                 },
>                 {
>                   locked_pending =3D 0x0,
>                   tail =3D 0x0
>                 }
>               }
>             }
>           }
>         }
>       },
>       xa_flags =3D 0x0,
>       xa_head =3D 0x0
>     },
>     idr_base =3D 0x0,
>     idr_next =3D 0x0
>   },
>   s2s_cp_lock =3D {
>     {
>       rlock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D 0x0
>             },
>             {
>               locked =3D 0x0,
>               pending =3D 0x0
>             },
>             {
>               locked_pending =3D 0x0,
>               tail =3D 0x0
>             }
>           }
>         }
>       }
>     }
>   },
>   nfsd_versions =3D 0x0,
>   nfsd4_minorversions =3D 0x0,
>   drc_hashtbl =3D 0xffff88810a2f0000,
>   max_drc_entries =3D 0x14740,
>   maskbits =3D 0xb,
>   drc_hashsize =3D 0x800,
>   num_drc_entries =3D {
>     counter =3D 0x0
>   },
>   counter =3D {{
>       lock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D 0x0
>             },
>             {
>               locked =3D 0x0,
>               pending =3D 0x0
>             },
>             {
>               locked_pending =3D 0x0,
>               tail =3D 0x0
>             }
>           }
>         }
>       },
>       count =3D 0x0,
>       list =3D {
>         next =3D 0xffff888103f98dd0,
>         prev =3D 0xffff8881114e9a18
>       },
>       counters =3D 0x607dc8402e10
>     }, {
>       lock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D 0x0
>             },
>             {
>               locked =3D 0x0,
>               pending =3D 0x0
>             },
>             {
>               locked_pending =3D 0x0,
>               tail =3D 0x0
>             }
>           }
>         }
>       },
>       count =3D 0x0,
>       list =3D {
>         next =3D 0xffff8881114e99f0,
>         prev =3D 0xffff88810b5743e0
>       },
>       counters =3D 0x607dc8402e14
>     }},
>   longest_chain =3D 0x0,
>   longest_chain_cachesize =3D 0x0,
>   nfsd_reply_cache_shrinker =3D {
>     count_objects =3D 0xffffffffa0e4e9b0 <nfsd_reply_cache_count>,
>     scan_objects =3D 0xffffffffa0e4f020 <nfsd_reply_cache_scan>,

Shrinker pointers look ok, as does its list_head.

>     batch =3D 0x0,
>     seeks =3D 0x1,
>     flags =3D 0x1,
>     list =3D {
>       next =3D 0xffff888111daf420,
>       prev =3D 0xffff8881114e9b30
>     },
>     nr_deferred =3D 0xffff88813a544a00
>   },
>   nfsd_ssc_lock =3D {
>     {
>       rlock =3D {
>         raw_lock =3D {
>           {
>             val =3D {
>               counter =3D 0x0
>             },
>             {
>               locked =3D 0x0,
>               pending =3D 0x0
>             },
>             {
>               locked_pending =3D 0x0,
>               tail =3D 0x0
>             }
>           }
>         }
>       }
>     }
>   },
>   nfsd_ssc_mount_list =3D {
>     next =3D 0x0,
>     prev =3D 0x0
>   },
>   nfsd_ssc_waitq =3D {
>     lock =3D {
>       {
>         rlock =3D {
>           raw_lock =3D {
>             {
>               val =3D {
>                 counter =3D 0x0
>               },
>               {
>                 locked =3D 0x0,
>                 pending =3D 0x0
>               },
>               {
>                 locked_pending =3D 0x0,
>                 tail =3D 0x0
>               }
>             }
>           }
>         }
>       }
>     },
>     head =3D {
>       next =3D 0x0,
>       prev =3D 0x0
>     }
>   },
>   nfsd_name =3D "\000\000\000\000\000\000\000\000\000\000\000\000\000\000=
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00=
0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0=
00\000\000\000\000\000\000\000\000\000\000\000\000",
>=20
>=20

nfsd_name is usually set to utsname, so that looks bogus.

>   fcache_disposal =3D 0x0,
>   siphash_key =3D {
>     key =3D {0x2a5ba10a35b36754, 0xd6b3a5a0e7696876}
>   },
>   nfs4_client_count =3D {
>     counter =3D 0x0
>   },
>   nfs4_max_clients =3D 0x1800,
>   nfsd_courtesy_clients =3D {
>     counter =3D 0x0
>   },
>   nfsd_client_shrinker =3D {
>     count_objects =3D 0xffffffffa0e742c0 <nfsd4_state_shrinker_count>,
>     scan_objects =3D 0xffffffffa0e73a90 <nfsd4_state_shrinker_scan>,
>     batch =3D 0x0,
>     seeks =3D 0x2,
>     flags =3D 0x1,
>     list =3D {
>       next =3D 0xffff8881114e9a58,
>       prev =3D 0xffffffffa131b280 <mmu_shrinker+32>
>     },
>     nr_deferred =3D 0xffff88813a5449d8
>   },
>   nfsd_shrinker_work =3D {
>     work =3D {
>       data =3D {
>         counter =3D 0x1
>       },
>       entry =3D {
>         next =3D 0x0,
>         prev =3D 0x0
>       },
>       func =3D 0x0
>     },
>     timer =3D {
>       entry =3D {
>         next =3D 0x0,
>         pprev =3D 0x0
>       },
>       expires =3D 0x0,
>       function =3D 0x0,
>       flags =3D 0x0
>     },
>     wq =3D 0x0,
>     cpu =3D 0x0
>   }
> }
> crash> kmem -s 0xFFFF8881114E9800
> CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
> ffff888100042dc0     1024      18325     18352   1147    32k  kmalloc-1k
>   SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
>   ffffea0004453a00  ffff8881114e8000     0     16         16     0
>   FREE / [ALLOCATED]
>   [ffff8881114e9800]
> crash>
>=20

Bit of a mixed bag here. A lot of these fields are corrupt, but not all
of them.

One thing that might interesting to rule out a UAF would be to
explicitly poison this struct in nfsd_exit_net. Basically do something
like this at the end of exit_net:

	memset(net, 0x7c, sizeof(*net));

That might help trigger an oops sooner after the problem occurs.

If you're feeling ambitious, another thing you could do is track down
some of the running nfsd's in the vmcore, find their rqstp values and
see whether the sockets are pointed at the same nfsd_net as the one you
found above (see nfsd() function to see how to get from one to the
other).

If they're pointed at a different nfsd_net that that would suggest that
we are looking at a UAF. If it's the same nfsd_net, then I'd lean more
toward some sort of memory scribble.
--=20
Jeff Layton <jlayton@kernel.org>
